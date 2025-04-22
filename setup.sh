#!/bin/bash

# Script to create symbolic links for config files to ~/.config/ and ~/

# Variables
REPO_DIR="$(pwd)"  # Assumes the script is run from the root of the repository
CONFIG_DIR="$HOME/.config"
echo "Repository directory: $REPO_DIR"
echo "Configuration directory: $CONFIG_DIR"

# ask user for confirmation
read -p "This script will install Homebrew and various command-line tools. Do you want to continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Exiting script..."
    exit 1
fi

# Step 1: Ensure Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# clone the repository
echo "Cloning the repository..."
cd $HOME
git clone https://github.com/sokinpui/terminal_dotfiles.git dotfiles
cd dotfiles


echo "Installing command-line tools..."
brew install automake            # Tool for generating GNU Standards-compliant Makefiles
brew install bat                 # Clone of cat(1) with syntax highlighting
brew install berkeley-db         # High performance key/value database
brew install bison               # Parser generator
brew install ccache              # Object-file caching compiler wrapper
brew install chruby              # Ruby environment tool
brew install colima              # Container runtimes on macOS
brew install coreutils           # GNU File, Shell, and Text utilities
brew install curl                # Get a file from an HTTP, HTTPS, or FTP server
brew install dialog              # Display user-friendly message boxes
brew install docker              # Pack, ship, and run applications as containers
brew install elasticsearch       # Distributed search & analytics engine
brew install kibana              # Analytics and search dashboard for Elasticsearch
brew install fd                  # Simple, fast alternative to find
brew install fetch               # Download assets from GitHub repositories
brew install fswatch             # Monitor a directory for changes
brew install fzf                 # Command-line fuzzy finder
brew install gh                  # GitHub command-line tool
brew install git-delta           # Syntax-highlighting pager for git and diff
brew install go                  # Go programming language
brew install gperf               # Perfect hash function generator
brew install gpgme               # Library access to GnuPG
brew install grip                # GitHub Markdown previewer
brew install htop                # Improved top (interactive process viewer)
brew install httpd               # Apache HTTP server
brew install icarus-verilog      # Verilog simulation and synthesis tool
brew install jdtls               # Java language server protocol
brew install jp                  # Terminal plots from JSON data
brew install jq                  # Command-line JSON processor
brew install julia               # Fast, dynamic programming language
brew install jupyterlab          # Interactive environments for code
brew install koekeishiya/formulae/skhd
brew install koekeishiya/formulae/yabai
brew install lf                  # Terminal file manager
brew install libffi              # Portable Foreign Function Interface library
brew install libgccjit           # JIT library for the GNU compiler collection
brew install luarocks            # Package manager for Lua
brew install lynx                # Text-based web browser
brew install meson               # Fast and user-friendly build system
brew install mysql               # Open source relational database
brew install neofetch            # System info script
brew install neovim              # Ambitious Vim-fork
brew install ollama              # Create, run, and share large language models
brew install opam                # OCaml package manager
brew install openjdk             # Development kit for Java
brew install openssh             # OpenBSD SSH connectivity tools
brew install openssl             # Cryptography and SSL/TLS Toolkit
brew install pipx                # Execute binaries from Python packages
brew install pngpaste            # Paste PNG into files
brew install python-tk           # Python interface to Tcl/Tk
brew install python              # Python 3.11
brew install pyvim               # Pure Python Vim clone
brew install qemu                # Generic machine emulator and virtualizer
brew install ripgrep             # Search tool like grep
brew install ruby-install        # Install Ruby and variants
brew install rust                # Safe, concurrent language
brew install shellcheck          # Static analysis for shell scripts
brew install showkey             # Simple keystroke visualizer
brew install sing-box            # Universal proxy platform
brew install syncthing           # File synchronization application
brew install tldr                # Simplified man pages
brew install tmux                # Terminal multiplexer
brew install trash-cli           # Command-line interface to trashcan
brew install tree                # Display directories as trees
brew install urlview             # URL extractor/launcher
brew install v2ray               # Platform for building proxies
brew install vim                 # Vi 'workalike' with additional features
brew install wget                # Internet file retriever
brew install xray                # Platform for building proxies
brew install xsel                # Command-line program for X selection
brew install zoxide              # Shell extension for navigation
brew install zsh-completions     # Additional completion definitions for zsh
brew install zsh-syntax-highlighting  # Syntax highlighting for zsh
brew install yqrashawn/goku/goku
brew install direnv
brew install cmake
brew install cloc

brew install font-lxgw-wenkai

brew install --cask basictex
brew install --cask discord
brew install --cask zoom
brew install --cask obsidian
brew install --cask google-chrome
brew install --cask logi-options+
brew install --cask visual-studio-code
brew install --cask v2rayu
brew install --cask wechat
brew install --cask whatsapp
brew install syncthing
brew install --cask raycast
brew install --cask mos
brew install --cask betterdisplay
brew install --cask maccy
brew install --cask dropbox
brew install onedrive
brew install --cask marta
brew install --cask microsoft-outlook
brew install --cask microsoft-word
brew install pomdtr/tap/ray

sudo ln -s /Applications/Marta.app/Contents/Resources/launcher /usr/local/bin/marta

brew tap dimentium/autoraise
brew install autoraise --with-dexperimental_focus_first

echo ""

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin installer=version-0.40.0
sudo ln -sf /Applications/kitty.app/Contents/MacOS/kitty /usr/local/bin/kitty

# Step 1: Create ~/.config directory if it doesn't exist
if [ ! -d "$CONFIG_DIR" ]; then
    echo "Creating $CONFIG_DIR..."
    mkdir -p "$CONFIG_DIR"
fi

# Step 2: Create symbolic links for config files
echo "Creating symbolic links for configuration files..."

# Files/Directories that go in ~/.config/
for tool in AutoRaise tmux  kitty bat lf skhd yabai; do
    if [ -d "$REPO_DIR/$tool" ] || [ -f "$REPO_DIR/$tool" ]; then
        ln -sfv "$REPO_DIR/$tool" "$CONFIG_DIR/$tool"
    else
        echo "Warning: $tool not found in repository"
    fi
done

echo "Symbolic linking complete! Please check the links and start your terminal tools."

ln -sfv $REPO_DIR/zsh-config/zsh $CONFIG_DIR/zsh

echo "Creating symbolic links for zsh configuration files..."
echo "Removing existing zsh configuration files..."
rm -f $HOME/.zprofile
rm -f $HOME/.zshrc
rm -f $HOME/.zshenv
echo ""

ln -sfv $REPO_DIR/zsh-config/zshrc $HOME/.zshrc
ln -sfv $REPO_DIR/zsh-config/zprofile $HOME/.zprofile

echo "Creating symbolic links for karabiner configuration files..."
ln -sfv $REPO_DIR/karabiner.edn $HOME/.config/karabiner.edn
echo ""

echo "Creating symbolic links for git configuration files..."
rm -f $HOME/.gitconfig
ln -sfv $REPO_DIR/gitconfig $HOME/.gitconfig
echo ""

cd /tmp
git clone https://github.com/sbmpost/AutoRaise.git
cd AutoRaise
make CXXFLAGS="-DOLD_ACTIVATION_METHOD -DEXPERIMENTAL_FOCUS_FIRST" && make install

cd $REPO_DIR

brew services start autoraise

echo "remove dock appear/dissapear animation"
defaults write com.apple.dock autohide-delay -int 0; killall Dock

echo "download open tablet driver"
#!/bin/bash

# Define the URL and download destination
URL="https://github.com/OpenTabletDriver/OpenTabletDriver/releases/latest/download/OpenTabletDriver-0.6.5.1_osx-x64.tar.gz"
DOWNLOAD_DIR="$HOME/Downloads"
FILE_NAME="OpenTabletDriver-0.6.5.1_osx-x64.tar.gz"
APP_FILE="$DOWNLOAD_DIR/OpenTabletDriver.app"

# Create Downloads directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR"

# Download the file
echo "Downloading OpenTabletDriver from $URL..."
curl -L -o "$DOWNLOAD_DIR/$FILE_NAME" "$URL"

# Check if download was successful
if [ $? -eq 0 ]; then
    echo "Download completed!"
else
    echo "Error: Failed to download the file."
    exit 1
fi

# Extract the tar.gz file directly (assuming it contains OpenTabletDriver.app)
echo "Extracting $FILE_NAME..."
tar -xzf "$DOWNLOAD_DIR/$FILE_NAME" -C "$DOWNLOAD_DIR"

# Check if extraction was successful and the .app exists
if [ $? -eq 0 ] && [ -d "$APP_FILE" ]; then
    echo "Extraction completed!"
else
    echo "Error: Failed to extract the file or OpenTabletDriver.app not found."
    exit 1
fi

# Move the .app to /Applications (requires sudo for system-wide access)
echo "Moving OpenTabletDriver.app to /Applications..."
sudo mv "$APP_FILE" /Applications/

# Check if move was successful
if [ $? -eq 0 ]; then
    echo "Successfully moved OpenTabletDriver.app to /Applications!"
else
    echo "Error: Failed to move the .app file to /Applications."
    exit 1
fi

# Clean up: remove the downloaded tar.gz
echo "Cleaning up..."
rm "$DOWNLOAD_DIR/$FILE_NAME"

echo "downloaded open tablet driver!"

ray completion zsh > $HOME/.config/zsh/autoload/_zay

git clone https://github.com/tmux-plugins/tmux-continuum ~/.config/tmux/plugins/tmux-continuum
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux/plugins/tmux-resurrect
