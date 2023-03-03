extends Node2D

var teste = false
var valor = 0
var numero = 0  #variável está com acento e nao aceita isso no GDScript
var lista = [] #não está declarada como uma variável
var nome = "Nauro " #Coloquei um nome para complementar com "baldo" que é um número ímpar


func _on_Button_pressed():
	#Coletando dados inseridos pelo usuário
	numero = int($LineEdit.text) #nome da variável com acento e faltou o cifrão no LineEdit
	$LineEdit.text = nome #não está declarada como var no escopo


func _on_Button2_pressed():
	#Incrementando o número inserido pelo usuário
	for i in range(10):
		numero+=i #variável declarada com N maiúscula e não atende o requisito como está no escopo
		lista.append(numero)
	$Label.text = str(numero)#Coloquei o número que recebe em formato de string


func _on_Button3_pressed():
	#Mudando o nome do usuário de acordo com os dados da lista
	#Se houver algum número ímpar o nome deve adicionar "baldo" ao final
	while(len(lista)): #podemos apagar o while e deixar os Ifs dentro do buttonPresed3
		
		var cont = 0 #variável não declarada
		
		#Não era necessáro usar essa variável
		
		if(lista[-1] % 2 == 1): #Tirei o "i" e coloquei -1 para pegar o último item da lista.
			
			print(lista)
			cont = 1 #tire o + por que não precisava no código
		
		if(cont != 0):
		
			nome = nome + "baldo"
		
		$Label2.text = nome
		
		break #é necessário para acabar com o loop do While.
