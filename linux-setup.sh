#!/bin/bash

# Script to set up a development environment on Ubuntu
# This script installs essential development tools and configures them by creating symbolic links.

# --- Step 1: User Confirmation ---
read -p "This script will install various command-line tools using apt and other installers. Do you want to continue? (y/n) " -n 1 -r
echo ""
# Use a POSIX-compliant `case` statement instead of bash-specific [[ ... ]]
case "$REPLY" in
[Yy])
  # If 'y' or 'Y', do nothing and continue with the script.
  ;;
*)
  # For any other input, exit.
  echo "Exiting script..."
  exit 1
  ;;
esac

# --- Step 2: System Update and Prerequisite Installation ---
echo "Updating package lists and installing prerequisites..."
sudo apt update
sudo apt install -y build-essential curl file git zsh

# --- Step 3: Clone Dotfiles Repository ---
echo "Cloning the dotfiles repository..."
cd "$HOME"
# Remove existing directory to ensure a fresh clone
rm -rf "$HOME/dotfiles"
git clone https://github.com/sokinpui/terminal_dotfiles.git dotfiles
cd "$HOME/dotfiles"

REPO_DIR="$(pwd)"
CONFIG_DIR="$HOME/.config"
echo "Repository directory: $REPO_DIR"
echo "Configuration directory: $CONFIG_DIR"

# --- Step 4: Install Command-Line Tools via apt ---
echo "Installing command-line tools with apt..."
sudo apt install -y \
  automake \
  bat \
  bison \
  ccache \
  cmake \
  cloc \
  coreutils \
  dialog \
  direnv \
  fd-find \
  fzf \
  htop \
  jq \
  luarocks \
  lynx \
  meson \
  neofetch \
  neovim \
  openjdk-17-jdk \
  python3 \
  python3-pip \
  python3-tk \
  ripgrep \
  shellcheck \
  syncthing \
  texlive-full \
  tldr-py \
  tmux \
  trash-cli \
  tree \
  wget \
  xclip \
  zsh-syntax-highlighting

mkdir -p "$HOME/.local/bin"
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >>"$HOME/.zshrc"
  export PATH="$HOME/.local/bin:$PATH"
fi

# Create symlinks for bat and fd for easier access
# On Ubuntu, 'bat' is 'batcat' and 'fd' is 'fdfind'
ln -sf /usr/bin/batcat "$HOME/.local/bin/bat"
ln -sf /usr/bin/fdfind "$HOME/.local/bin/fd"

# Install Python packages
echo "Installing Python packages with pipx and pip..."
sudo apt install -y pipx
pipx ensurepath
pipx install neovim-remote
# Use --break-system-packages for newer Ubuntu/Debian versions
pip3 install --break-system-packages pynvim

# --- Step 7: Create Symbolic Links for Config Files ---

# Create ~/.config directory if it doesn't exist
if [ ! -d "$CONFIG_DIR" ]; then
  echo "Creating $CONFIG_DIR..."
  mkdir -p "$CONFIG_DIR"
fi

echo "Creating symbolic links for configuration files..."

# List of dotfiles/directories to link into ~/.config/
# Cleaned up for Linux compatibility
DOTFILES=(
  nvim
  tmux
  kitty
  bat
  lf
  yazi
)

for tool in "${DOTFILES[@]}"; do
  # Check if the source file/directory exists in the cloned repo
  if [ -e "$REPO_DIR/$tool" ]; then
    ln -sfv "$REPO_DIR/$tool" "$CONFIG_DIR/$tool"
  else
    echo "Warning: Config for '$tool' not found in repository. Skipping."
  fi
done

# --- Zsh Configuration ---
echo "Creating symbolic links for zsh configuration files..."
ln -sfv "$REPO_DIR/zsh" "$CONFIG_DIR/zsh"
# Remove default files if they exist to avoid conflicts
rm -f "$HOME/.zshrc" "$HOME/.zshenv" "$HOME/.zprofile"
# Create links in home directory
ln -sfv "$REPO_DIR/zsh/zshrc" "$HOME/.zshrc"
ln -sfv "$REPO_DIR/zsh/zprofile" "$HOME/.zprofile"
echo ""

# --- Git Configuration ---
echo "Creating symbolic link for git configuration..."
rm -f "$HOME/.gitconfig"
ln -sfv "$REPO_DIR/gitconfig" "$HOME/.gitconfig"
echo ""

# --- TMUX Plugin Manager ---
echo "Cloning TMUX plugin manager (tpm)..."
mkdir -p "$CONFIG_DIR/tmux/plugins"
git clone https://github.com/tmux-plugins/tpm "$CONFIG_DIR/tmux/plugins/tpm"

# Install Rust and Cargo (required for yazi)
if ! command -v cargo &>/dev/null; then
  echo "Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  # Add cargo to the current shell's PATH
  source "$HOME/.cargo/env"
fi

sudo apt install -y ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick
# Install Yazi
if ! command -v yazi &>/dev/null; then
  cd $HOME
  git clone https://github.com/sxyazi/yazi.git
  cd $HOME/yazi
  cargo build --release --locked
  cd $HOME
fi

# Install Deno
if ! command -v deno &>/dev/null; then
  echo "Installing Deno..."
  curl -fsSL https://deno.land/x/install/install.sh | sh
fi

# Install Ollama
echo "Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# Install Docker
if ! command -v docker &>/dev/null; then
  echo "Installing Docker..."
  sudo apt-get install -y ca-certificates gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  # Add user to the docker group to run docker without sudo
  sudo usermod -aG docker "$USER"
  echo "Docker installed. You may need to log out and back in for group changes to take effect."
fi

# --- Final Instructions ---
echo "-----------------------------------------------------"
echo "Setup complete!"
echo ""
echo "Next Steps:"
echo "1. Change your default shell to Zsh by running:"
echo "   chsh -s $(which zsh)"
echo "2. Log out and log back in, or reboot your system for all changes to take effect."
echo "3. Open tmux and press 'Prefix + I' (usually Ctrl+b + I) to install the plugins."
echo "4. To use yazi plugins, run 'yazi' and then type ':pkg install' to install configured plugins."
echo "-----------------------------------------------------"

chsh -s "$(which zsh)" || echo "Failed to change default shell to Zsh. Please run 'chsh -s $(which zsh)' manually."
