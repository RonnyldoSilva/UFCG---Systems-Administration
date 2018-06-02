#!/bin/bash

# ALuno: Ronnyldo Rodrigues Eloy da Silva - 116110707

# pegando todos os arquivos do diretorio atual
ls > diretorio.txt

totalDeExercicios=0

if [ $# -eq 2 ]; then
	# foi dado na linha de comando o numero do exercicio e o nome do aluno:	

	grep ".sh" diretorio.txt | grep "EXERCICIO_" | grep "$2" > _exercicios.txt
	grep ".in" diretorio.txt | grep "EXERCICIO_" > _entradas.txt
	grep ".out" diretorio.txt | grep "EXERCICIO_" > _saidas.txt
	
	while read exercicio;do
		
		totalDeExercicios=$(( $totalDeExercicios + 1 ))

		exercicioAtual=$( echo $exercicio | cut -d"_" -f2 )
		if [ $exercicioAtual -eq $1 ]; then
			
			arquivo=$( echo $exercicio | cut -d"." -f1 )
				
			echo -e "$arquivo:"

			indice=1
	
			while read entrada; do
			
				entradaAtual=$( echo $entrada | cut -d"_" -f2 )
			
				if [ $exercicioAtual -eq $entradaAtual ]; then
				
					echo -e "-SAIDA PARA A ENTRADA $indice:"
					indice=$(( $indice + 1 ))				
	
					echo $exercicio > entradaAtual.txt
				
					echo ""
				
					echo -e "-DIFERENÇA PARA A SAIDA ESPERADA:"
				
					while read saida
					do
				
						saidaAtual=$( echo $saida | cut -d"_" -f2 )
			
						if [ $saidaAtual -eq $entradaAtual ]; then
				
							diff entradaAtual.txt $saida

						fi
					done < _saidas.txt

					echo ""
				fi
			
			done < _entradas.txt

			echo ""
		fi
	done < _exercicios.txt
	
elif [ $# -eq 1 ]; then
	# foi dado na linha de comando apenas o numero do exercicio.	

	grep ".sh" diretorio.txt | grep "EXERCICIO_" > _exercicios.txt
	grep ".in" diretorio.txt | grep "EXERCICIO_" > _entradas.txt
	grep ".out" diretorio.txt | grep "EXERCICIO_" > _saidas.txt
	
	while read exercicio;do

		totalDeExercicios=$(( $totalDeExercicios + 1 ))
		
		exercicioAtual=$( echo $exercicio | cut -d"_" -f2 )
		if [ $exercicioAtual -eq $1 ]; then
			
			arquivo=$( echo $exercicio | cut -d"." -f1 )
				
			echo -e "$arquivo:"

			indice=1
	
			while read entrada; do
			
				entradaAtual=$( echo $entrada | cut -d"_" -f2 )
			
				if [ $exercicioAtual -eq $entradaAtual ]; then
				
					echo -e "-SAIDA PARA A ENTRADA $indice:"
					indice=$(( $indice + 1 ))				
	
					echo $exercicio > entradaAtual.txt
				
					echo ""
				
					echo -e "-DIFERENÇA PARA A SAIDA ESPERADA:"
				
					while read saida
					do
				
						saidaAtual=$( echo $saida | cut -d"_" -f2 )
			
						if [ $saidaAtual -eq $entradaAtual ]; then
				
							diff entradaAtual.txt $saida

						fi
					done < _saidas.txt

					echo ""
				fi
			
			done < _entradas.txt

			echo ""
		fi
	done < _exercicios.txt
else 
	
	grep ".sh" diretorio.txt | grep "EXERCICIO_" > _exercicios.txt
	grep ".in" diretorio.txt | grep "EXERCICIO_" > _entradas.txt
	grep ".out" diretorio.txt | grep "EXERCICIO_" > _saidas.txt
	
	while read exercicio;do

		totalDeExercicios=$(( $totalDeExercicios + 1 ))		
		
		arquivo=$( echo $exercicio | cut -d"." -f1 )
				
		echo -e "$arquivo:"

		indice=1
	
		while read entrada; do
			
			exercicioAtual=$( echo $exercicio | cut -d"_" -f2 )
			
			entradaAtual=$( echo $entrada | cut -d"_" -f2 )
			
			if [ $exercicioAtual -eq $entradaAtual ]; then
				
				echo -e "-SAIDA PARA A ENTRADA $indice:"
				indice=$(( $indice + 1 ))				
	
				echo $exercicio > entradaAtual.txt
				
				echo ""
				
				echo -e "-DIFERENÇA PARA A SAIDA ESPERADA:"
				
				while read saida
				do
				
					saidaAtual=$( echo $saida | cut -d"_" -f2 )
			
					if [ $saidaAtual -eq $entradaAtual ]; then
				
						diff entradaAtual.txt $saida

					fi
				done < _saidas.txt

				echo ""
			fi
			
		done < _entradas.txt

		echo ""
	
	done < _exercicios.txt
fi

echo ""
echo "Funcionalidade extra:"
echo -e "O total de exercicios é: $totalDeExercicios"
