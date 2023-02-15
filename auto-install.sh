#!/bin/bash

sudo apt-get -qq update -y
sudo apt-get -qq upgrade -y

read -p "Install git? (Y/n) " -r -n 2 INSTALL_GIT

if [[ $INSTALL_GIT =~ ^[Yy]$ ]] || [[ -z $INSTALL_GIT ]];
then
  echo "Installing batcat and vim..."
  sudo apt-get -qq install bat vim -y

  # Alias for batcat to avoid conflicts, see:
  # https://github.com/sharkdp/bat#on-ubuntu-using-apt
  mkdir -p ~/.local/bin
  ln -fs /usr/bin/batcat ~/.local/bin/bat

  echo "Installing git..."
  sudo apt-get -qq install git -y

  echo "Configuring git..."
  cp ./git/.gitconfig ~/.gitconfigz

  read -p "Enter git provider (GITHUB/gitlab): " -r PROVIDER_GIT

  if [[ $PROVIDER_GIT =~ ^[Gg][Ii][Tt][Hh][Uu][Bb]$ ]];
  then
    PROVIDER_GIT="github"
  elif [[ $PROVIDER_GIT =~ ^[Gg][Ii][Tt][Ll][Aa][Bb]$ ]];
  then
    PROVIDER_GIT="gitlab"
  else
    PROVIDER_GIT="github"
  fi

  read -p "Enter your name: " -r NAME_GIT
  read -p "Enter your email: " -r EMAIL_GIT
  read -p "Enter your sign key:" -rs SIGN_KEY_GIT

  {
    echo "[user]"
    echo "  name = $NAME_GIT"
    echo "  email = $EMAIL_GIT"
    echo "  signingkey = $SIGN_KEY_GIT"
  } >> ~/.config/git/$PROVIDER_GIT.conf
fi

read -p "Install bash configuration? (Y/n) " -r -n 2 INSTALL_BASH 

if [[ $INSTALL_BASH =~ ^[Yy]$ ]] || [[ -z $INSTALL_BASH ]];
then
  echo "Installing bash aliases..."
  cp ./bash/.bash_aliases ~/.bash_aliases
fi

# Check if a program exists, see:
# https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
if command -v code &> /dev/null
then
  read -p "Install VS Code configuration? (Y/n) " -r -n 2 INSTALL_VS_CODE

  if [[ $INSTALL_VS_CODE =~ ^[Yy]$ ]] || [[ -z $INSTALL_VS_CODE ]];
  then
    echo "Installing VS Code configuration..."
    cp ./vscode/settings.json ~/.config/Code/User/settings.json
  fi
fi

sudo apt-get -qq autoremove -y