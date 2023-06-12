#!/bin/sh

# Laptop setup!
# This is for macs, tested and used on Ventura
# Updated: 2023-06-12

# xcode developer tools
xcode-select --install

# ohmyzsh (gotta keep it all looking pretty!)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# even prettier
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME=.*/ZSH_THEME=\"powerlevel10k/powerlevel10k\"/g' ~.zshrc
cp .p10k.zsh $HOME/.p10k.zsh

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shelling)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# iterm2
brew install --cask iterm2

# python3
brew install python3
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# poetry
brew install poetry

# conda
brew install --cask miniconda
conda init zsh

# vscode
brew install --cask visual-studio-code
code --install-exension rust-lang.rust-analyzer
code --install-extension ms-toolsai.jupyter
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension REditorSupport.r


# jupyter lab (creates conda env as well)
conda create --name jupyter -y jupyterlab nb_conda_kernels

# jupyter launcher
# activates the correct conda environment, and opens jupyterlab in a screen
touch ~/.jupyter_launcher.sh
cat <<EOT >> ~/.jupyter_launcher.sh
#!/bin/bash

function run_jupyter() {
  conda activate jupyter
  screen jupyter lab
}
EOT
chmod +x ~/.jupyter_launcher.sh
echo "source ~/.jupyter_launcher.sh" >> ~/.zshrc

# r
brew install r

# tidyverse and dependencies
brew install harfbuzz fribidi freetype libpng libtiff libjpeg
R -e "install.packages('tidyverse')"

# if this throws a hdiutil error, you likely have a process blocking hdiutil
# rebooting can help
brew install --cask rstudio
