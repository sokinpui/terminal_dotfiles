#!/usr/bin/env bash

set -e

REPO_DIR=$(cd "$(dirname "$0")" && pwd)
CONFIG_DIR="$HOME/.config"

create_symlink() {
  local src=$1
  local dst=$2
  [ -L "$dst" ] && rm "$dst"
  [ -e "$dst" ] && [ ! -L "$dst" ] && mv "$dst" "$dst.bak"
  ln -sfv "$src" "$dst"
}

ensure_directories() {
  mkdir -p "$HOME/.local/bin"
  mkdir -p "$HOME/.local/scripts"
  mkdir -p "$HOME/.config"
  mkdir -p "$HOME/projects"

  # Ensure default metadata exists if not already present
  local meta_file="$REPO_DIR/scripts/tmux-sessionizer-meta"
  if [ ! -f "$meta_file" ]; then
    cat <<EOF > "$meta_file"
#!/usr/bin/env bash

IGNORED_PATHS=( ~/tmp/* )
INITIAL_DIRECTORIES=( ~/projects )
SSH_HOSTS=( )
EOF
    chmod +x "$meta_file"
  fi
}

setup_macos() {
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew update

  brew install \
    pipx \
    tmux \
    bat \
    zsh \
    cmake \
    gettext \
    fd \
    colima \
    neofetch \
    ripgrep \
    python3-pip \
    git \
    go \
    tree-sitter \
    font-lxgw-wenkai \
    luarocks

  brew tap FelixKratz/formulae
  brew tap yqrashawn/goku
  brew install \
    borders \
    skhd \
    yabai \
    goku

  brew install --cask \
    font-jetbrains-mono-nerd-font \
    discord \
    zoom \
    obsidian \
    google-chrome \
    logi-options+ \
    visual-studio-code \
    v2rayu \
    wechat \
    whatsapp \
    raycast \
    mos \
    betterdisplay \
    microsoft-outlook \
    microsoft-word \
    karabiner-elements

  defaults write -g InitialKeyRepeat -int 10
  defaults write -g KeyRepeat -int 1

  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin installer=version-0.40.0
  brew uninstall neovim || true

  sudo ln -sf /Applications/kitty.app/Contents/MacOS/kitty /usr/local/bin/kitty
  curl -fsSL https://deno.land/install.sh | sh
}

setup_ubuntu() {
  sudo apt update
  sudo apt-get install -y --ignore-missing \
    tmux \
    unzip \
    cmake \
    gettext \
    vim \
    neofetch \
    ripgrep \
    tldr \
    tree \
    zoxide \
    direnv \
    pipx \
    fd-find \
    python3-pip \
    zsh \
    git \
    golang-go \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    python3-openssl \
    luarocks

  sudo apt remove -y neovim || true

  create_symlink "$(which fdfind)" "$HOME/.local/bin/fd"
  curl -fsSL https://deno.land/install.sh | sh
}

setup_fedora() {
  sudo dnf update -y
  sudo dnf groupinstall -y \
    "Development Tools"
  sudo dnf install -y --skip-unavailable \
    openssl-devel \
    bzip2-devel \
    libffi-devel \
    zlib-devel \
    readline-devel \
    sqlite-devel \
    pipx \
    unzip \
    cmake \
    gettext \
    vim \
    tmux \
    bat \
    zsh \
    fd-find \
    ripgrep \
    htop \
    tldr \
    zoxide \
    cloc \
    python3-pip \
    git \
    lf \
    golang \
    luarocks

  sudo dnf remove -y neovim || true

  if command -v fdfind &>/dev/null; then
    create_symlink "$(which fdfind)" "$HOME/.local/bin/fd"
  fi

  curl -fsSL https://deno.land/install.sh | sh
}

dispatch_install() {
  local os_type
  os_type=$(uname -s)

  if [ "$os_type" = "Darwin" ]; then
    setup_macos
    return
  fi

  [ "$os_type" != "Linux" ] && {
    echo "Unsupported OS: $os_type"
    exit 1
  }

  local distro
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    distro=$ID
  else
    distro=$(lsb_release -i | awk '{print tolower($3)}')
  fi

  case "$distro" in
  ubuntu | debian) setup_ubuntu ;;
  fedora) setup_fedora ;;
  *)
    echo "Unsupported Linux distribution: $distro"
    exit 1
    ;;
  esac
}

link_dotfiles() {
  echo "Linking configuration files to $CONFIG_DIR..."
  for item in *; do
    case "$item" in
    "README.md" | "images" | "scripts" | "zsh" | "setup.sh" | "dotfiles") continue ;;
    esac
    create_symlink "$REPO_DIR/$item" "$CONFIG_DIR/$item"
  done

  create_symlink "$REPO_DIR/scripts" "$HOME/.local/scripts"
  create_symlink "$REPO_DIR/zsh/zshrc" "$HOME/.zshrc"
  create_symlink "$REPO_DIR/zsh/zshenv" "$HOME/.zshenv"
  create_symlink "$REPO_DIR/zsh/zprofile" "$HOME/.zprofile"
}

install_python_tools() {
  pipx install neovim-remote
  pipx install trash-cli

  if pip3 install --help | grep -q "break-system-packages"; then
    pip3 install pynvim --break-system-packages
    return
  fi
  pip3 install pynvim
}

install_go_tools() {
  export PATH=$PATH:$(go env GOPATH)/bin
  env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest
  go install github.com/walles/moor/v2/cmd/moor@latest
}

install_rust_tools() {
  if ! command -v cargo &>/dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
  fi

  cargo install tree-sitter-cli
}

install_fzf() {
  if [ -d "$HOME/.fzf" ]; then
    return
  fi
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --all
}

install_neovim_source() {
  echo "Installing Neovim from source..."
  local nvim_repo="$HOME/projects/neovim"
  mkdir -p "$HOME/projects"

  if [ ! -d "$nvim_repo" ]; then
    git clone https://github.com/neovim/neovim.git "$nvim_repo"
  fi

  pushd "$nvim_repo" >/dev/null
  git checkout master
  git pull origin master
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  popd >/dev/null
}

install_node_via_nvm() {
  echo "Installing Node.js via NVM..."
  export NVM_DIR="$HOME/.nvm"
  if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
  fi

  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  if command -v nvm &>/dev/null; then
    nvm install 24
    node -v
    npm -v
  fi
}

main() {
  ensure_directories

  echo "Detected OS: $(uname -s)"
  dispatch_install

  if [ ! -f "$REPO_DIR/setup.sh" ] && [ ! -d "$REPO_DIR/.git" ]; then
    git clone https://github.com/sokinpui/terminal_dotfiles.git dotfiles
    cd dotfiles
    REPO_DIR="$(pwd)"
  fi

  link_dotfiles
  install_python_tools
  install_go_tools
  install_rust_tools
  install_fzf
  install_neovim_source
  install_node_via_nvm

  echo "Setup complete! Please restart your shell."
}

main "$@"
