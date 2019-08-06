#! /bin/bash


sudo pip install virtualenvwrapper

§cat ~/.bash_profile | grep "virtualenvwrapper.sh" || {
	mkdir -p $HOME/.virtualenvs
	cat >> ~/.bash_profile <<EXP
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh
EXP
}