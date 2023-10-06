# emacs
This is a short written example to replicate my emacs config files.

## Installation
The installation part is very similar to Hubisans wsl-emacs installation guide found at https://github.com/hubisan/emacs-wsl#install-emacs-281.

The following commands first need to be ran.
```shell
sudo apt update
sudo apt upgrade
sudo apt install gcc-10 libxpm-dev libgif-dev libgtk-3-dev libwebkit2gtk-4.0-dev libgccjit-10-dev libxpm-dev libjpeg-dev libgif-dev libtiff-dev libgnutls28-dev libjansson-dev libtinfo-dev
```
The available emacs versions can be found at : https://ftp.gnu.org/pub/gnu/emacs/. The one I used as of writing this was 29.1.
Just as Hubisans instruction said download and extract
```shell
wget https://ftp.gnu.org/pub/gnu/emacs/emacs-29.1.tar.gz
tar -xzvf emacs-29.1.tar.gz
```
Now move into the folder and run the following commands
```shell
cd emacs-29.1
export CC="gcc-10" CXX="gcc-10"
./configure --with-json --with-native-compilation --with-xwidgets
make
sudo make install
rm ~/emacs-29.1.tar.gz
```
We can later use sudo make uninstall in this folder to uninstall and update to another version.

Now using emacs -nw (-nw to run it in console window) we can start using emacs.

## Configuration
To start off we need to install packages, to access all packages we need to add melpa. This can be done by editing/adding the file ~/.emacs to contain
```
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
```
Restarting and opening list-packages should now give you more options. Install the following packages:
* dumb-jump : Allows jumping to function declaration.
* gh-md     : Render MD files.
* gruber-darker-theme : Theme used.
* magit : Allows for quick and easy git management.
* smex : IDE for M-x interface.

  Now copy the .emacs file from this repo to ~/.emacs and restart emacs. Press "y" two times and now Emacs shouldbe fully configured.
