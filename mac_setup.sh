#!/bin/sh

# Laptop setup!
# This is for macs

# xcode developer tools
xcode-select --install

# ohmyzsh (gotta keep it all looking pretty!)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# iterm2
brew cask install iterm2

# python3
brew install python3
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# conda
brew cask install miniconda
conda init zsh

# pycharm
# if this throws a hdiutil error, you likely have a process blocking hdiutil
# rebooting can help
brew cask install pycharm-ce

# jupyter lab (creates conda env as well)
conda create --name jupyter -y jupyterlab nb_conda_kernels

# jupyter launcher
# activates the correct conda environment, and opens jupyterlab in a screen
touch .jupyter_launcher.sh
cat <<EOT >> .jupyter_launcher.sh
#!/bin/bash

function run_jupyter() {
  conda activate jupyter
  screen jupyter lab
}
EOT
chmod +x .jupyter_launcher.sh
echo "source .jupyter_launcher.sh" >> ~/.zshrc

# r
brew install r

# if this throws a hdiutil error, you likely have a process blocking hdiutil
# rebooting can help
brew cask install rstudio
