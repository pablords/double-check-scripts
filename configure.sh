#!/bin/bash



sed -i '/DOUBLE_CHECK_HOME/d' ~/.bashrc
sed -i '/alias dc-dc/d' ~/.bashrc

export DOUBLE_CHECK_HOME=~/double-check


echo "adicionando variavel ambiente " $DOUBLE_CHECK_HOME


if [ $SHELL = "/bin/bash" ]; then
    echo "export DOUBLE_CHECK_HOME="$DOUBLE_CHECK_HOME>>~/.bashrc
    echo "export DOUBLE_CHECK_HOME="$DOUBLE_CHECK_HOME>>~/.profile
    echo "alias dc-dc='docker-compose -f $DOUBLE_CHECK_HOME/double-check-composes/compose-dev.yml'">>~/.bashrc
    echo "alias dc-dc='docker-compose -f $DOUBLE_CHECK_HOME/double-check-composes/compose-dev.yml'">>~/.profile
    source ~/.bashrc
    source ~/.profile
else
    echo "export DOUBLE_CHECK_HOME="$DOUBLE_CHECK_HOME>>~/.zshrc
    echo "export DOUBLE_CHECK_HOME="$DOUBLE_CHECK_HOME>>~/.profile
    echo "alias dc-dc='docker-compose -f $DOUBLE_CHECK_HOME/double-check-composes/compose-dev.yml'">>~/.zshrc
    echo "alias dc-dc='docker-compose -f $DOUBLE_CHECK_HOME/double-check-composes/compose-dev.yml'">>~/.profile
    source ~/.zshrc
    source ~/.profile
fi

mkdir $DOUBLE_CHECK_HOME

cp ./clone-repo.sh $DOUBLE_CHECK_HOME

cd $DOUBLE_CHECK_HOME

./clone-repo.sh

sudo setfacl -R -d -m o::rwx $DOUBLE_CHECK_HOME
sudo setfacl -R -m o::rwx $DOUBLE_CHECK_HOME