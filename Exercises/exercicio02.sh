#!/bin/bash

#Autor: Ronnyldo Rodrigues Eloy da Silva - 116110707 
#Data: 20 de Julho de 2016
#2º exercício de Administração de Sistema
#Professor: Matheus G. Rego

# variáveis setadas na linha de comando.
n=$1
s=$2
P_USER=$3                     

# Caso algumas das variáveis estiver com valor nulo,
# será pedido para setá-las mais uma vez.
if [ $# != 3 ]; then
	echo "entre com n:"
	read n
	echo "entre com s:"
	read s
	echo "entre com P_USER:"
	read P_USER
fi

# Verificando se todas as variáveis estão setadas.
# Ou se $n ou $s é menor ou igual a 0.
if [ -z $n ] || [ -z $s ] || [ -z $P_USER ] || [ $n -le 0 ] || [ $s -le 0 ] ; then
	exit 1
fi

flag=0

cpuTotal=0.0
cpuMaior=
cpuMenor=

memTotal=0.0
memMaior=
memMenor=

contagemRSS=0

for execute in $( seq $n ); do
	sleep $s
	
	ps aux > saida1.txt

	while read line; do
		usuario=$( echo $line | cut -d" " -f1 | egrep "$P_USER" )
	
		if ! [ -z $usuario ]; then
			flag=1
			echo $line >> saida2.txt
			
			# capturando todos os programas dos usuários que comecem com $P_USER
			echo $line | cut -d" " -f11 >> todosOsProgramas.txt
			
			# a)
			cpu=$( echo $line | cut -d" " -f3 )
			cpuTotal=$( echo | awk "{ print $cpuTotal + $cpu }" )
		
			# b)
			mem=$( echo $line | cut -d" " -f4 )
			memTotal=$( echo | awk "{ print $memTotal + $mem }" )
			
			# c)
			if [ -z $cpuMaior ]; then
				cpuMaior=$cpu
				cpuMenor=$cpu
			else
				if [ $(bc <<< "$cpu > $cpuMaior") -eq 1 ]; then
					cpuMaior=$cpu
				fi
				
				if [ $(bc <<< "$cpu < $cpuMenor") -eq 1 ]; then
					cpuMenor=$cpu
				fi 
			fi
			
			# d)
			if [ -z $memMaior ]; then
				memMaior=$mem
				memMenor=$mem
			else
				if [ $(bc <<< "$mem > $memMaior") -eq 1 ]; then
					memMaior=$mem
				fi
				
				if [ $(bc <<< "$mem < $memMenor") -eq 1 ]; then
					memMenor=$mem
				fi 
			fi
			
			# funcionalidade extra)
			rss=$( echo $line | cut -d" " -f6 )
			rssTotal=$( echo | awk "{ print $rssTotal + $rss }" )
			contagemRSS=$(( $contagemRSS + 1 ))
		fi
	
	done < saida1.txt 

done

# Se nenhum processo for listado nenhuma fez, ele deve sair com saída 2.
if [ $flag -eq 0 ]; then
	echo -e "\nNenhum processo desse usuário foi encontrado.\n"
	exit 2
else 
	echo -e "\nTodos os programas que estavam em processo durante a busca relacionada aos usuários estão no arquivo: todosOsProgramas.txt\n"	
	
	# a)
	echo -e "\nA)\no valor total encontrado de %CPU é $cpuTotal\n"
	
	# b)
	echo -e "B)\no valor total encontrado de %MEM é $memTotal\n"
	
	# c)
	echo -e "C)\no maior valor de %CPU encontrado é $cpuMaior"
	echo -e "o menor valor de %CPU encontrado é $cpuMenor\n"
	
	#d)
	echo -e "D)\no maior valor de %MEM encontrado é $memMaior"
	echo -e "o menor valor de %MEM encontrado é $memMenor\n"
	
	# Funcionalidade extra
	rssTotal=$( echo | awk "{ print $rssTotal / $contagemRSS }" )
	echo -e "FUNCIONALIDADE EXTRA)\nA média do valor de RSS é $rssTotal\n"
fi
