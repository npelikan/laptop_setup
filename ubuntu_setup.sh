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
apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
apt install r-base -y

# rstudio
wget "https://download1.rstudio.org/desktop/debian9/x86_64/rstudio-1.3.1056-amd64.deb"
gdebi rstudio-1.3.1056-amd64.deb
