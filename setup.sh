#!/bin/sh

echo 'Start setup'
cd ~

echo '************ generate a new SSH key?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    ssh-keygen -t rsa -b 4096 ;;
  * ) echo "skip" ;;
esac

echo '************ install homebrew?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ;;
  * ) echo "skip" ;;
esac

echo '************ install Git?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    brew install git ;;
  * ) echo "skip" ;;
esac

echo '************ clone dotfiles?[Y/n]'
read ANSWER

if [ -e ~/dotfiles ]; then
  command="cd ~/dotfiles && git pull origin master"
else
  command="git clone https://github.com/suy0n9/dotfiles.git"
fi
case $ANSWER in
  "" | "Y" | "y" )
    eval $command ;;
  * ) echo "skip" ;;
esac


echo '************ install ansible?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    brew install python
    brew install ansible ;;
  * ) echo "skip" ;;
esac

echo '************ run ansible?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    cd ~/dotfiles
    ansible-playbook -i hosts -vv localhost.yml ;;
  * ) echo "skip" ;;
esac

echo '************ setup dotfiles?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    cd ~/dotfiles
    ./symlink.sh ;;
  * ) echo "skip" ;;
esac

echo 'Mac setup finished!!'
