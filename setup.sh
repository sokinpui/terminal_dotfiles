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
  mkdir -p "$HOME/.local/man"
  mkdir -p "$HOME/.local/scripts"
  mkdir -p "$HOME/.config"
  mkdir -p "$HOME/projects"
  mkdir -p "$REPO_DIR/scripts"

  # Ensure default metadata exists if not already present
  local meta_file="$REPO_DIR/scripts/tmux-sessionizer-meta"
  if [ ! -f "$meta_file" ]; then
    cat <<EOF >"$meta_file"
#!/usr/bin/env bash

IGNORED_PATHS=( ~/tmp/* )
INITIAL_DIRECTORIES=( ~/projects )
SSH_HOSTS=( )
EOF
    chmod +x "$meta_file"
  fi
}

install_brew_items() {
  local mode="$1"
  shift
  local items=("$@")

  for item in "${items[@]}"; do
    if [ "$mode" = "cask" ]; then
      brew install --cask "$item" --yes || echo "Failed to install cask: $item. Skipping..."
    else
      brew install "$item" --yes || echo "Failed to install: $item. Skipping..."
    fi
  done
}

setup_macos() {
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  brew update

  local formulae=(
    pipx
    tmux
    bat
    zsh
    cmake
    gettext
    fd
    colima
    neofetch
    ripgrep
    python3-pip
    git
    go
    tree-sitter
    yazi
    font-lxgw-wenkai
    luarocks
  )

  local casks=(
    font-jetbrains-mono-nerd-font
    discord
    zoom
    obsidian
    google-chrome
    logi-options+
    visual-studio-code
    v2rayu
    wechat
    whatsapp
    raycast
    mos
    betterdisplay
    microsoft-outlook
    microsoft-word
    karabiner-elements
  )

  install_brew_items "formula" "${formulae[@]}"

  brew tap FelixKratz/formulae
  brew tap yqrashawn/goku
  brew install \
    borders \
    goku

  brew install asmvik/formulae/skhd
  curl -L https://raw.githubusercontent.com/asmvik/yabai/master/scripts/install.sh | sh /dev/stdin ~/.local/bin ~/.local/man

  install_brew_items "cask" "${casks[@]}"

  defaults write -g InitialKeyRepeat -int 10
  defaults write -g KeyRepeat -int 1

  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin installer=version-0.40.0
  brew uninstall neovim || true

  sudo ln -sf /Applications/kitty.app/Contents/MacOS/kitty /usr/local/bin/kitty
}

setup_ubuntu() {
  sudo apt update
  sudo apt-get install -y --ignore-missing \
    tmux \
    unzip \
    cmake \
    gettext \
    vim \
    fastfetch \
    ripgrep \
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
    clang \
    libclang-dev \
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
}

setup_fedora() {
  sudo dnf update -y
  sudo dnf install -y fedora-workstation-repositories
  sudo dnf config-manager setopt google-chrome.enabled=1

  sudo dnf group install -y development-tools
  sudo dnf install -y \
    openssl-devel \
    bzip2-devel \
    libffi-devel \
    zlib-devel \
    readline-devel \
    clang \
    clang-devel \
    clang-tools-extra \
    libX11-devel \
    libXext-devel \
    libXfixes-devel \
    sqlite-devel \
    pipx \
    unzip \
    cmake \
    gettext \
    vim \
    google-chrome-stable \
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
    golang \
    luarocks

  sudo dnf remove -y neovim || true

  if command -v fdfind &>/dev/null; then
    create_symlink "$(which fdfind)" "$HOME/.local/bin/fd"
  fi
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
    "README.md" | "images" | "setup.sh" | "dotfiles") continue ;;
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

  if pip3 install --help | grep -q "break-system-packages"; then
    pip3 install pynvim --break-system-packages
    return
  fi
  pip3 install pynvim
}

install_go_tools() {
  export PATH=$PATH:$(go env GOPATH)/bin
  env CGO_ENABLED=0 go install -trimpath -ldflags="-s -w" github.com/gokcehan/lf@latest
  go install github.com/walles/moor/v2/cmd/moor@latest
  go install github.com/sokinpui/worktree/cmd/worktree@latest
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

install_gomi() {
  local target="$HOME/.local/bin/gomi"
  local legacy="$HOME/bin/gomi"

  if [ -f "$legacy" ]; then
    mv "$legacy" "$target"
    rmdir "$HOME/bin" 2>/dev/null || true
  fi

  [ -f "$target" ] && return

  curl -fsSL https://gomi.dev/install | bash
  if [ -f "$legacy" ]; then
    mv "$legacy" "$target"
    rmdir "$HOME/bin" 2>/dev/null || true
  fi
}

install_sync_clip() {
  local repo_url="https://github.com/sokinpui/sync-clip.git"
  local dest_dir="$HOME/projects/sync-clip"
  local config_dir="$HOME/.config/sync-clip"

  mkdir -p "$dest_dir"
  mkdir -p "$config_dir"

  if [ ! -d "$dest_dir/.git" ]; then
    git clone "$repo_url" "$dest_dir"
  fi

  pushd "$dest_dir" >/dev/null
  go install ./cmd/sc ./cmd/scs
  popd >/dev/null

  touch "$config_dir/scs.conf"
  touch "$config_dir/sc.conf"
}

install_yazi() {
  [ "$(uname -s)" = "Darwin" ] && return
  command -v yazi &>/dev/null && return

  echo "Installing Yazi..."
  local arch
  arch=$(uname -m)
  local target

  case "$arch" in
  x86_64) target="x86_64-unknown-linux-gnu" ;;
  aarch64) target="aarch64-unknown-linux-gnu" ;;
  *)
    echo "Unsupported architecture for Yazi: $arch"
    return
    ;;
  esac

  local tmp_dir
  tmp_dir=$(mktemp -d)
  local zip_path="$tmp_dir/yazi.zip"

  curl -L "https://github.com/sxyazi/yazi/releases/latest/download/yazi-$target.zip" -o "$zip_path"
  unzip -q "$zip_path" -d "$tmp_dir"
  sudo mv "$tmp_dir"/yazi-*/{ya,yazi} /usr/local/bin/
  rm -rf "$tmp_dir"
}

install_coder() {
  echo "Installing Coder..."
  local repo_url="https://github.com/sokinpui/coder.git"
  local dest_dir="$HOME/projects/coder"

  mkdir -p "$HOME/projects"

  if [ ! -d "$dest_dir" ]; then
    git clone "$repo_url" "$dest_dir"
  fi

  pushd "$dest_dir" >/dev/null
  git pull
  ./install.sh
  popd >/dev/null
}

install_kmonad() {
  [ "$(uname -s)" != "Linux" ] && return
  command -v kmonad &>/dev/null && return

  echo "Installing KMonad..."
  local version="0.4.5"
  local url="https://github.com/kmonad/kmonad/releases/download/${version}/kmonad"
  local tmp_bin
  tmp_bin=$(mktemp)

  curl -L "$url" -o "$tmp_bin"
  sudo mv "$tmp_bin" /usr/local/bin/kmonad
  sudo chmod +x /usr/local/bin/kmonad

  echo "Setting up KMonad service..."
  local service_file="$REPO_DIR/kmonad/kmonad.service"
  local systemd_path="/etc/systemd/system/kmonad.service"

  # Ensure the service file exists with correct content
  cat <<EOF >"$service_file"
[Unit]
Description=KMonad Keyboard Daemon
After=local-fs.target

[Service]
Type=simple
ExecStart=/usr/local/bin/kmonad /home/so/.config/kmonad/config.kbd
Restart=always
RestartSec=3
Nice=-20

[Install]
WantedBy=multi-user.target
EOF

  sudo cp "$service_file" "$systemd_path"
  sudo systemctl daemon-reload
  sudo systemctl enable kmonad
  sudo systemctl start kmonad
}

main() {
  if [ ! -f "$REPO_DIR/setup.sh" ] && [ ! -d "$REPO_DIR/.git" ]; then
    git clone https://github.com/sokinpui/terminal_dotfiles.git dotfiles
    cd dotfiles
    REPO_DIR="$(pwd)"
  fi

  ensure_directories

  echo "Detected OS: $(uname -s)"
  dispatch_install

  link_dotfiles
  install_python_tools
  install_go_tools
  install_rust_tools
  install_fzf
  install_node_via_nvm
  install_gomi
  install_sync_clip
  install_yazi
  install_coder
  install_kmonad
  install_neovim_source

  echo "Setup complete! Please restart your shell."
}

main "$@"
