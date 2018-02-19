#!/bin/bash

printf "Coloque o caminho do projeto: \n"
read CAMINHO

printf "Digite o nome do usuário: \n"
read USER

printf "Digite a chave do usuário: \n"
read CHAVE

echo "Criando a branch de update da chave e atualizando"
cd $CAMINHO && git checkout -b updateChave && git pull origin master && git merge master

echo "Criando o arquivo da chave"
filename="$CAMINHO/linux/templates/publickeys/$USER.pub"

if [ -f "$filename" ]
then
    echo "Arquivos ja existe. Deseja substituir? [y/n]"
    read REPLY
    if [[ $REPLY =~ ^[Yy]$ ]]
    then 
        rm $filename
        touch $filename
    else
        exit 1
    fi
else
    touch "$filename"
fi

echo "Inserindo a chave"
echo $CHAVE >> "$filename"

echo "Fazendo o commit e enviando ao servidor"
cd $CAMINHO && git add . && git commit -m "Update de Chave" && git pull --no-edit origin updateChave && git push origin updateChave
exit 1