#!/bin/bash
# Administração de Sistemas
# Autor: Ronnyldo Rodrigues - 116110707
# 13 de Julho de 2016

arquivo=/home/rony/workspace/aulas/administracao-de-sistemas/shell/access_log

saida1=arquivo.txt
locais=locais.txt
remotes=remotes.txt

# Questão 4
grep " - - " $arquivo > $saida1

# Questão 5
grep "local" $saida1 > $locais
grep "remote" $saida1 > $remotes

# a
totalLocal=$( grep "local" $locais | wc -l )
echo -e "\nForam feitas $totalLocal requisições locais."

# b
totalRemote=$( grep "remote" $remotes | wc -l )
echo -e "\nForma feitas $totalRemote requisições remotas."

horaLocal=0
horaRemote=0

while read line
do	
	hora=$( echo  $line | cut -d":" -f2 )
	hora=${hora#0}
	horaLocal=$(( $hora + $horaLocal ))
done < "$locais"

while read line
do
	hora=$( echo  $line | cut -d":" -f2 )
	hora=${hora#0}
	horaRemote=$(( $hora + $horaRemote )) 
done < "$remotes"

# c
echo -e "\nEm média, qual a hora (apenas o campo hora e só o valor inteiro) em que requisições locais são feitas: "
bc <<< "scale=5; ($horaLocal/$totalLocal)"

# d
echo -e "\nem média, qual a hora (apenas o campo hora e só o valor inteiro) em que requisições remotas são feitas: "
bc <<< "scale=5; ($horaRemote/$totalRemote)"

# Questão 6
if [ $totalLocal -gt $totalRemote ]
then
	echo -e "\nA requisição mais feita é Local"
elif [ $totalLocal -lt $totalRemote ]
then
	echo -e "\nA requisição mais feita é Remote"
else
	echo -e "Ambas as requisições tem quantidades iguais."
fi

echo ""

