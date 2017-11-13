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
touch "$CAMINHO/linux/templates/publickeys/$USER.pub"

echo "Inserindo a chave"
echo $CHAVE >> "$CAMINHO/linux/templates/publickeys/$USER.pub"

echo "Fazendo o commit e enviando ao servidor"
cd $CAMINHO && git add . && git commit -m "Update de Chave" && git push origin updateChave