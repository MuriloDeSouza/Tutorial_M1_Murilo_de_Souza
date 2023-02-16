extends Node # instancia a classe Node2D

var status = 1 #Se for 0 (dragão parado) se for 1 (dragão em movimento, como se eu estivesse dado play)
var vscore = 0 #ele conta a pontuação conforme o dragão passa pelos obstáculos e está com zero pois começa mesmo com 0 pontos.
var x = 1.5 #aqui é a base da velocidade do dragão cravado em 1.5 e se usa os multiplicadores de velocidade 1 nas linhas de código.
var y = 1.5 #aqui o movimento é horizontal do dragão fazendo com que ele suba e desca, (como ja esta cravado em 1.5 ele ja desce normalmente sem clicar) e também, nas outras linhas de código se tem os multiplicadores por esses números cravados.
>>>>>>> 60856e4421830aa96d5811d85982d2b4c6314d43

# executa essa função ao carregar o jogo
func _ready():
	# oculta o "gameover"
	$gameover.hide()


# executa essa função a cada frame (60 FPS)
func _process(delta):
	
	if status == 1: # jogando
		
		# movimenta o cenário do fundo
		$background.position.x -= 2*x
		if ($background.position.x) < -200:
			$background.position.x = 600
			
		# movimenta as colunas para colisão
		$columns.position.x -= 3*x #Aqui eu posso multiplicar a velocidade do dragão alterando o valor entre 1 e infinito
		if ($columns.position.x) < -550:
			$columns.position.x = rand_range(0, 350) - 50
			$columns.position.y = rand_range(0, 400) - 200
		
		# puxa o dragão para baixo
		$dragon.position.y += y

		# se bateu no fundo, não desce mais e termina o jogo
		if $dragon.position.y > 480:
			$dragon.position.y = 480
			status = 0 # muda o status para "parado"

		# se bateu no teto, não sobe mais
		if $dragon.position.y < -20:
			$dragon.position.y = -20
			
		# se apertou seta para baixo, aumenta o valor de y (posição vertical) do dragão
		if Input.is_action_pressed("ui_down"):
			$dragon.position.y += 3 #sensibilidade do movimento vertical para baixo

		# se apertou seta para cima, diminui o valor de y (posição vertical) do dragão
		if Input.is_action_pressed("ui_up"):
			$dragon.position.y -= 6 #sensibilidade do movimento vertical para baixo.
			
	elif status == 0: # parado
		
		$dragon/dragonImages.playing = false # faz dragão parar de bater as asas
		$gameover.show() # exibe imagem gameover

		# se apertou enter ou space, recomeça o jogo
		if Input.is_action_pressed("ui_accept"):
			$score.set_text("0") # zera o score
			vscore = 0 # zera o score
			status = 1 # muda o status para "jogando"
			$dragon/dragonImages.playing = true # faz dragão voltar a bater as asas
			$dragon.position.y = 0 # volta o dragão para a posição original
			$columns.position.x = 400 # muda a posição das colunas
			$gameover.hide() # oculta o gameover

			

# executa essa função quando o dragão bate na coluna
func _on_columns_body_shape_entered(body_id, body, body_shape, local_shape):
	if (local_shape < 2): # esse node tem 3 shapes de colisão: 0 e 1 são as colunas
		status = 0 # muda o status para "parado"

# executa essa função quando o dragão atravessa entre as colunas
func _on_columns_body_shape_exited(body_id, body, body_shape, local_shape):
	if (local_shape == 2): # esse node tem 3 shapes de colisão: 0 e 1 são as colunas
		vscore += 7 # aumenta o score
		$score.set_text(str(vscore)) # atualiza o painel
		

