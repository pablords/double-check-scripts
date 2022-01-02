#!/bin/bash

set -e

cd $DOUBLE_CHECK_HOME

repos=$(find -maxdepth 1 -type d)
branchName=$1
silent=$2

if [ ! -z $silent ] && [ $silent != "--silent" ] ; then
    echo "Parâmetro inválido"
    exit 1
fi

if [ "$branchName" == "--help" ]; then 
    echo -e "\n\n--------------------------------------------------------------"
    echo -e "Realiza PULL de todos os repositórios DOUBLE_CHECK à partir da branch informada"
    echo -e "Utilização:"
    echo -e "\e[33m" "pull-all-repos-to-branch.sh [branch] [--silent]" "\e[0m"
    echo -e ""
    echo -e "--silent: não pede confirmação para prosseguir"
    echo -e "--------------------------------------------------------------\n\n"
    exit 0
fi

if [ ! -z $silent ]; then
    confirmation="S"
else
    echo -e "\e[33m"
    read -p "ATENÇÃO: este script vai OBTER todas as modificações branch ${branch} e fazer o pull na sua branch atual. Confirma? (s/N)" confirmation
    echo -e "\e[0m"
fi    

if [ $confirmation != "S" ] && [ $confirmation != "s" ]; then
    exit 0
fi

for repo in $repos; do
    if [ $repo == "." ] || [ $repo == "./scripts" ] ; then
        continue
    fi

    if [ -d $repo/.git ] || [ -L $repo/.git ] || [ -f $repo/.git ]; then
        echo -e "\e[32m" "Alterando o ${repo}..." "\e[0m"

        if [[ "$branchName" == "master" ]]; then
            existed_in_remote="of course, dude!"
        else
            existed_in_remote=$(git -C $repo ls-remote --heads origin ${branchName})
        fi
        

        if [[ -z ${existed_in_remote} ]]; then
            echo -e "\e[33m" "Branch $branchName não encontrada\n\n" "\e[0m"
            continue
        fi

        git -C $repo pull origin $branchName

        echo -e "\n\n"
    fi
done
