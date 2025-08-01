# .zshrc

# ----------------------------------------------------
# Ubuntu/Debian:
# ----------------------------------------------------
# sudo apt update
# sudo apt install zsh git fzf fd-find trash-cli xclip neovim bat ripgrep htop tmux build-essential python3-pip python3-venv

# In General, you would like to do this:
# sudo ln -sfv $(which fdfind) /usr/local/bin/fd
# sudo ln -sfv $(which batcat) /usr/local/bin/bat

# Install zoxide (a smarter cd tool):
# curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash


# ----------------------------------------------------
# Fedora/RHEL/CentOS:
# ----------------------------------------------------
# sudo dnf check-update
# sudo dnf install zsh git-core fzf fd-find trash-cli xclip neovim bat ripgrep htop tmux libffi-devel zlib-devel openssl-devel bzip2-devel readline-devel sqlite-devel python3-pip python3-virtualenv


# --------------------------------------------------------------------
# §1. Environment Variables
# --------------------------------------------------------------------

# Set a sane terminal type
export TERM='xterm-256color'
if [ -n "$TMUX" ]; then
    export TERM='screen-256color'
fi

# Set default editor
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"

# Set default pagers
export PAGER='less -R'
export MANPAGER='nvim +Man!'
export MANWIDTH=99

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Go
export GOPATH=$HOME/go

# Cargo/Rust
export CARGOPATH="$HOME/.cargo"

# Pipx
export PIPX_HOME="$HOME/.local/pipx"

# PATH configuration
# ------------------
# Prepending paths ensures they are found first.
# Using a temporary array to avoid duplicates.
typeset -U path
path=(
  "$HOME/.local/bin"
  "$CARGOPATH/bin"
  "$GOPATH/bin"
  "$HOME/.gem/bin"
  "$HOME/.pub-cache/bin" # For Flutter/Dart
  "$PIPX_HOME/bin"
  $path
)

# --------------------------------------------------------------------
# §2. Zsh Options & History
# --------------------------------------------------------------------

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt EXTENDED_HISTORY

# Options
setopt AUTOPUSHD              # Automatically push directories onto the stack
setopt PUSHD_IGNORE_DUPS      # Don't push duplicate directories
setopt PROMPT_SUBST           # Allow prompt substitution (for git prompt)
setopt MENU_COMPLETE          # Automatically highlight first element of completion menu
setopt AUTO_LIST              # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD       # Complete from both ends of a word.
unsetopt AUTO_MENU            # Do not show completion menu on first tab
unsetopt BEEP                 # No beeps
set -o IGNORE_EOF             # Prevent accidental exit with Ctrl-D
set -o VI                     # Vi mode

# Make key response faster
KEYTIMEOUT=1

# --------------------------------------------------------------------
# §3. Completion System
# --------------------------------------------------------------------

autoload -Uz compinit
compinit -i

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"

# Basic completion style
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' complete true
zstyle ':completion:alias-expension:*' completer _expand_alias
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

# Colorize completion menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Sort files by modification time
zstyle ':completion:*' file-sort modification

# Use vim keys in tab complete menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[' vi-cmd-mode

# --------------------------------------------------------------------
# §4. Keybindings, Aliases & Functions
# --------------------------------------------------------------------

# 4.1. Keybindings & Editor Integration
# -------------------------------------

# Edit line in vim with Ctrl-e
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# Delete whole word with Ctrl + Backspace
bindkey '^H' backward-kill-word

# In vi-mode, go up a directory with 'k' at an empty prompt
bindkey -s '^k' '^[k'

# Clipboard integration (requires `xclip` to be installed)
# On Wayland, you might need `wl-copy`/`wl-paste` from `wl-clipboard`
vi-yank-xclip() {
  zle vi-yank
  echo "$CUTBUFFER" | xclip -selection clipboard
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

paste-from-xclip() {
  LBUFFER+="$(xclip -selection clipboard -o)"
}
zle -N paste-from-xclip
bindkey '^v' paste-from-xclip
bindkey -M vicmd 'p' paste-from-xclip # vi-paste is default `p`

# 4.2. Vi Mode Enhancements (Text Objects, Surround)
# -------------------------------------------------
# Text objects for "({[<'``'>]})"
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Surround plugin
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd gs add-surround
bindkey -M visual gs add-surround

# Cursor style for vi mode
echo -ne '\e[2 q'

zle-keymap-select() {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q' # block cursor
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q' # beam cursor
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # start in insert mode
    echo -ne "\e[6 q" # beam cursor
}
zle -N zle-line-init
precmd_functions+=(zle-keymap-select)
preexec_functions+=(zle-keymap-select)

_reset_cursor_color() printf '\e]112\a'

zle-keymap-select() {
    if [[ $KEYMAP = vicmd ]]; then
        printf '\e]12;Cyan\a'
    else
        _reset_cursor_color
    fi
}
zle -N zle-keymap-select

zle-line-init() zle -K viins
zle -N zle-line-init

precmd_functions+=(_reset_cursor_color)

# 4.3. Aliases
# ------------
# Quick editing
alias v="$EDITOR"
alias vim="$EDITOR"
alias vi="$EDITOR"
alias nv="$EDITOR"
alias sz="source $HOME/.zshrc"
alias vzz="$EDITOR $HOME/.zshrc"

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias d-='cd -'
# `d` function for directory stack navigation
d() {
  [[ $1 == "-" ]] && cd - && return
  [ -z "$1" ] && dirs -v && return || cd +"$1"
}

# File system operations
alias rm="trash-put"
alias rs="trash-restore"
alias mv="mv -v"
alias cp="cp -r -v"
alias ls="ls --group-directories-first --color=always -h"
alias ll="ls --group-directories-first --color=always -hl"
alias la="ls --group-directories-first -lah --color=always"
mkd() { mkdir -p "$@" && echo "created $(realpath "$@")"; }
mkdc() { mkdir -p "$@" && cd "${@: -1}"; }

# Process and system
alias df='df -h'
alias htop="TERM=xterm-256color htop"

# Search and filter
alias fd="fd --color auto -i"
alias grep="grep --color=auto -i"
alias rg="rg -i"

# Git
alias g="git"
alias ga="git add"
alias gaa="git add -A"
alias gm="git commit"
alias gmm="git commit -m"
gp() {
  # Push and set upstream for new branches
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  remote_branch=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
  if [ -z "$remote_branch" ]; then
    git push --set-upstream origin "$current_branch"
  else
    git push
  fi
}
alias gcl="git clone"
alias gb="git branch"
alias gl="git log --graph --oneline --decorate --all"
alias gd="git diff"
alias gds="git diff --staged"
alias gdt="git difftool"
alias gs="git status -sb"
alias gsu="git status --untracked-files"
alias gco="git checkout"
alias gsw="git switch"

# Python
alias python="python3"
alias pip="pip3"
alias pyvenv="python3 -m venv .venv && source .venv/bin/activate"

# 4.4. FZF-based shortcuts & functions
# -------------------------------------
# requires `fzf` and `fd` to be installed

# Ctrl-F: Find and edit a file
open-recent-edit-file() {
    local file
    file=$(fd --type f --hidden --follow --exclude .git | fzf --height 40% --reverse --preview 'bat --color=always {}')
    if [[ -n "$file" ]]; then
        # Puts the command in the buffer to be executed on enter
        BUFFER="$EDITOR ${(q)file}"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N open-recent-edit-file
bindkey '^f' open-recent-edit-file

# Ctrl-Y: Interactively cd into a subdirectory
open-recent-cd() {
    local dir
    dir=$(fd --type d --hidden --follow --exclude .git | fzf --height 40% --reverse)
    if [[ -n "$dir" ]]; then
        BUFFER="cd ${(q)dir}"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N open-recent-cd
bindkey '^y' open-recent-cd

# Ctrl-G: Interactively cd into a subdirectory of the git repo root
jump-to-dir-in-git-repo() {
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        # Not in a git repo, fallback to normal cd
        open-recent-cd
        return
    fi
    local git_root=$(git rev-parse --show-toplevel)
    local dir
    dir=$(fd --type d --hidden --follow --exclude .git . "$git_root" | fzf --height 40% --reverse)
    if [[ -n "$dir" ]]; then
        BUFFER="cd ${(q)dir}"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N jump-to-dir-in-git-repo
bindkey '^g' jump-to-dir-in-git-repo

# Ctrl-T: FZF file finder (built-in)
# This uses fzf's own keybinding script logic, which is more robust.

# source <(fzf --zsh)
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Customize fzf options
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Ctrl-R: FZF history search (built-in)

# Alt-C: FZF directory changer (built-in)
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# --------------------------------------------------------------------
# §5. Tool & Plugin Initializations
# --------------------------------------------------------------------

# Zoxide (smarter cd)
# To install: curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias z="zi" # `zi` is the interactive version
fi

# Direnv (per-directory environments)
# To install: sudo apt install direnv / sudo dnf install direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# rbenv (Ruby version manager)
# To install: git clone https://github.com/rbenv/rbenv.git ~/.rbenv
if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - --no-rehash zsh)"
fi

# Conda (Python environment manager)
# If you use Conda, uncomment the following lines and adjust the path if necessary.
# __conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "$HOME/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="$HOME/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup

# --------------------------------------------------------------------
# §6. Prompt
# --------------------------------------------------------------------

# 6.1. Git Prompt Logic
# Sourced from original git-prompt.sh
# -----------------------
# check whether printf supports -v
__git_printf_supports_v=
printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1

# stores the divergence from upstream in $p
# used by GIT_PS1_SHOWUPSTREAM
__git_ps1_show_upstream ()
{
	local key value
	local svn_remote svn_url_pattern count n
	local upstream_type=git legacy="" verbose="" name=""

	svn_remote=()
	# get some config options from git-config
	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
	while read -r key value; do
		case "$key" in
		bash.showupstream)
			GIT_PS1_SHOWUPSTREAM="$value"
			if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
				p=""
				return
			fi
			;;
		svn-remote.*.url)
			svn_remote[$((${#svn_remote[@]} + 1))]="$value"
			svn_url_pattern="$svn_url_pattern\\|$value"
			upstream_type=svn+git # default upstream type is SVN if available, else git
			;;
		esac
	done <<< "$output"

	# parse configuration values
	local option
	for option in ${GIT_PS1_SHOWUPSTREAM}; do
		case "$option" in
		git|svn) upstream_type="$option" ;;
		verbose) verbose=1 ;;
		legacy)  legacy=1  ;;
		name)    name=1 ;;
		esac
	done

	# Find our upstream type
	case "$upstream_type" in
	git)    upstream_type="@{upstream}" ;;
	svn*)
		# get the upstream from the "git-svn-id: ..." in a commit message
		# (git-svn uses essentially the same procedure internally)
		local -a svn_upstream
		svn_upstream=($(git log --first-parent -1 \
					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
			svn_upstream=${svn_upstream[${#svn_upstream[@]} - 2]}
			svn_upstream=${svn_upstream%@*}
			local n_stop="${#svn_remote[@]}"
			for ((n=1; n <= n_stop; n++)); do
				svn_upstream=${svn_upstream#${svn_remote[$n]}}
			done

			if [[ -z "$svn_upstream" ]]; then
				# default branch name for checkouts with no layout:
				upstream_type=${GIT_SVN_ID:-git-svn}
			else
				upstream_type=${svn_upstream#/}
			fi
		elif [[ "svn+git" = "$upstream_type" ]]; then
			upstream_type="@{upstream}"
		fi
		;;
	esac

	# Find how many commits we are ahead/behind our upstream
	if [[ -z "$legacy" ]]; then
		count="$(git rev-list --count --left-right \
				"$upstream_type"...HEAD 2>/dev/null)"
	else
		# produce equivalent output to --count for older versions of git
		local commits
		if commits="$(git rev-list --left-right "$upstream_type"...HEAD 2>/dev/null)"
		then
			local commit behind=0 ahead=0
			for commit in $commits
			do
				case "$commit" in
				"<"*) ((behind++)) ;;
				*)    ((ahead++))  ;;
				esac
			done
			count="$behind	$ahead"
		else
			count=""
		fi
	fi

	# calculate the result
	if [[ -z "$verbose" ]]; then
		case "$count" in
		"") # no upstream
			p="" ;;
		"0	0") # equal to upstream
			p="=" ;;
		"0	"*) # ahead of upstream
			p=">" ;;
		*"	0") # behind upstream
			p="<" ;;
		*)	    # diverged from upstream
			p="<>" ;;
		esac
	else # verbose, set upstream instead of p
		case "$count" in
		"") # no upstream
			upstream="" ;;
		"0	0") # equal to upstream
			upstream="|u=" ;;
		"0	"*) # ahead of upstream
			upstream="|u+${count#0	}" ;;
		*"	0") # behind upstream
			upstream="|u-${count%	0}" ;;
		*)	    # diverged from upstream
			upstream="|u+${count#*	}-${count%	*}" ;;
		esac
		if [[ -n "$count" && -n "$name" ]]; then
			__git_ps1_upstream_name=$(git rev-parse \
				--abbrev-ref "$upstream_type" 2>/dev/null)
			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
				upstream="$upstream \${__git_ps1_upstream_name}"
			else
				upstream="$upstream ${__git_ps1_upstream_name}"
				# not needed anymore; keep user's
				# environment clean
				unset __git_ps1_upstream_name
			fi
		fi
	fi

}

__git_ps1_colorize_gitstring ()
{
	if [[ -n ${ZSH_VERSION-} ]]; then
		local c_red='%F{red}'
		local c_green='%F{green}'
		local c_lblue='%F{blue}'
		local c_clear='%f'
	else
		# Using \001 and \002 around colors is necessary to prevent
		# issues with command line editing/browsing/completion!
		local c_red=$'\001\e[31m\002'
		local c_green=$'\001\e[32m\002'
		local c_lblue=$'\001\e[1;34m\002'
		local c_clear=$'\001\e[0m\002'
	fi
	local bad_color=$c_red
	local ok_color=$c_green
	local flags_color="$c_lblue"

	local branch_color=""
	if [ $detached = no ]; then
		branch_color="$ok_color"
	else
		branch_color="$bad_color"
	fi
	if [ -n "$c" ]; then
		c="$branch_color$c$c_clear"
	fi
	b="$branch_color$b$c_clear"

	if [ -n "$w" ]; then
		w="$bad_color$w$c_clear"
	fi
	if [ -n "$i" ]; then
		i="$ok_color$i$c_clear"
	fi
	if [ -n "$s" ]; then
		s="$flags_color$s$c_clear"
	fi
	if [ -n "$u" ]; then
		u="$bad_color$u$c_clear"
	fi
}

__git_eread ()
{
	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
}

__git_sequencer_status ()
{
	local todo
	if test -f "$g/CHERRY_PICK_HEAD"
	then
		r="|CHERRY-PICKING"
		return 0;
	elif test -f "$g/REVERT_HEAD"
	then
		r="|REVERTING"
		return 0;
	elif __git_eread "$g/sequencer/todo" todo
	then
		case "$todo" in
		p[\ \	]|pick[\ \	]*)
			r="|CHERRY-PICKING"
			return 0
		;;
		revert[\ \	]*)
			r="|REVERTING"
			return 0
		;;
		esac
	fi
	return 1
}

__git_ps1 ()
{
	local exit=$?
	local pcmode=no
	local detached=no
	local ps1pc_start='\u@\h:\w '
	local ps1pc_end='\$ '
	local printf_format=' (%s)'

	case "$#" in
		2|3)	pcmode=yes
			ps1pc_start="$1"
			ps1pc_end="$2"
			printf_format="${3:-$printf_format}"
			PS1="$ps1pc_start$ps1pc_end"
		;;
		0|1)	printf_format="${1:-$printf_format}"
		;;
		*)	return $exit
		;;
	esac

	local ps1_expanded=yes
	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=no
	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=no

	local repo_info rev_parse_exit_code
	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
		--is-bare-repository --is-inside-work-tree \
		--short HEAD 2>/dev/null)"
	rev_parse_exit_code="$?"

	if [ -z "$repo_info" ]; then
		return $exit
	fi

	local short_sha=""
	if [ "$rev_parse_exit_code" = "0" ]; then
		short_sha="${repo_info##*$'\n'}"
		repo_info="${repo_info%$'\n'*}"
	fi
	local inside_worktree="${repo_info##*$'\n'}"
	repo_info="${repo_info%$'\n'*}"
	local bare_repo="${repo_info##*$'\n'}"
	repo_info="${repo_info%$'\n'*}"
	local inside_gitdir="${repo_info##*$'\n'}"
	local g="${repo_info%$'\n'*}"

	if [ "true" = "$inside_worktree" ] &&
	   [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED-}" ] &&
	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
	   git check-ignore -q .
	then
		return $exit
	fi

	local sparse=""
	if [ -z "${GIT_PS1_OMITSPARSESTATE-}" ] &&
	   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
		sparse="|SPARSE"
	fi

	local r=""
	local b=""
	local step=""
	local total=""
	if [ -d "$g/rebase-merge" ]; then
		__git_eread "$g/rebase-merge/head-name" b
		__git_eread "$g/rebase-merge/msgnum" step
		__git_eread "$g/rebase-merge/end" total
		r="|REBASE"
	else
		if [ -d "$g/rebase-apply" ]; then
			__git_eread "$g/rebase-apply/next" step
			__git_eread "$g/rebase-apply/last" total
			if [ -f "$g/rebase-apply/rebasing" ]; then
				__git_eread "$g/rebase-apply/head-name" b
				r="|REBASE"
			elif [ -f "$g/rebase-apply/applying" ]; then
				r="|AM"
			else
				r="|AM/REBASE"
			fi
		elif [ -f "$g/MERGE_HEAD" ]; then
			r="|MERGING"
		elif __git_sequencer_status; then
			:
		elif [ -f "$g/BISECT_LOG" ]; then
			r="|BISECTING"
		fi

		if [ -n "$b" ]; then
			:
		elif [ -h "$g/HEAD" ]; then
			b="$(git symbolic-ref HEAD 2>/dev/null)"
		else
			local head=""
			if ! __git_eread "$g/HEAD" head; then
				return $exit
			fi
			b="${head#ref: }"
			if [ "$head" = "$b" ]; then
				detached=yes
				b="$(
				case "${GIT_PS1_DESCRIBE_STYLE-}" in
				(contains)
					git describe --contains HEAD ;;
				(branch)
					git describe --contains --all HEAD ;;
				(tag)
					git describe --tags HEAD ;;
				(describe)
					git describe HEAD ;;
				(* | default)
					git describe --tags --exact-match HEAD ;;
				esac 2>/dev/null)" ||

				b="$short_sha..."
				b="($b)"
			fi
		fi
	fi

	if [ -n "$step" ] && [ -n "$total" ]; then
		r="$r $step/$total"
	fi

	local conflict=""
	if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" == "yes" ]] &&
	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
		conflict="|CONFLICT"
	fi

	local w=""
	local i=""
	local s=""
	local u=""
	local h=""
	local c=""
	local p=""
	local upstream=""

	if [ "true" = "$inside_gitdir" ]; then
		if [ "true" = "$bare_repo" ]; then
			c="BARE:"
		else
			b="GIT_DIR!"
		fi
	elif [ "true" = "$inside_worktree" ]; then
		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
		   [ "$(git config --bool bash.showDirtyState)" != "false" ]
		then
			git diff --no-ext-diff --quiet || w="*"
			git diff --no-ext-diff --cached --quiet || i="+"
			if [ -z "$short_sha" ] && [ -z "$i" ]; then
				i="#"
			fi
		fi
		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
		   git rev-parse --verify --quiet refs/stash >/dev/null
		then
			s="$"
		fi

		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
		   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
		   git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
		then
			u="%${ZSH_VERSION+%}"
		fi

		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
		   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
			h="?"
		fi

		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
			__git_ps1_show_upstream
		fi
	fi

	local z="${GIT_PS1_STATESEPARATOR-" "}"

	b=${b##refs/heads/}
	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
		__git_ps1_branch_name=$b
		b="\${__git_ps1_branch_name}"
	fi

	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
		__git_ps1_colorize_gitstring
	fi

	local f="$h$w$i$s$u$p"
	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}${conflict}"

	if [ $pcmode = yes ]; then
		if [ "${__git_printf_supports_v-}" != yes ]; then
			gitstring=$(printf -- "$printf_format" "$gitstring")
		else
			printf -v gitstring -- "$printf_format" "$gitstring"
		fi
		PS1="$ps1pc_start$gitstring$ps1pc_end"
	else
		printf -- "$printf_format" "$gitstring"
	fi

	return $exit
}

# 6.2. Prompt Appearance
# ----------------------
# Git prompt features
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=true

# Python virtualenv helper
function virtualenv_info {
  [ "$VIRTUAL_ENV" ] && echo -n "%F{yellow}("`basename "$VIRTUAL_ENV"`") %f"
}

# Pre-command hook to set the prompt string
precmd () {
  # Format: [user@host PWD]<git-info>
  #         »
  local venv_info=$(virtualenv_info)
  __git_ps1 "${venv_info}%B%F{red}[%f%n@%m %F{cyan}%~%f%F{red}]%f%b" "
%B»%b " "|%s"
}

# Continuation prompt
PS2='%F{green}%_>%f '
