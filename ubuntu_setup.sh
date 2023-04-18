#!/bin/sh

# Laptop setup!
# This was created and tested on Ubuntu 20.04

# gimme root!
echo "$(whoami)"
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# general updates
apt update
apt upgrade -y

# utils
apt-get install wget curl -y

# zsh, and make that the default shell
apt install zsh -y
chsh -s $(which zsh)
# make it pretty
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# even prettier
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" | tee -a ~/.zshrc
cp .p10k.zsh $HOME/.p10k.zsh

# condas
wget "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh

# jupyter lab (creates conda env as well)
conda create --name jupyter -y jupyterlab nb_conda_kernels
conda install -n jupyter -c conda-forge nodejs

# jupyter launcher
# activates the correct conda environment, and opens jupyterlab in a screen
apt install screen -y
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

# pycharm
snap install pycharm-community --classic

# r
apt install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
apt install -y r-base r-base-dev

# tidyverse and dependencies
apt install -y libcurl4-openssl-dev libssl-dev libxml2-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev
R -e "install.packages('tidyverse')"

# rstudio
wget -O rstudio-latest.deb "https://rstudio.org/download/latest/stable/desktop/bionic/rstudio-latest-amd64.deb"
gdebi rstudio-latest.deb
