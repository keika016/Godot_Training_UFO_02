extends Area2D

var SPEED = 100
var direction = Vector2()
var width
var height
var hit = false
var lose = false
var click = 0
var accum = 0
var isTen = false

func _ready():
	# lam vi tri cua Vat the o trung tam cua man hinh
	position = get_viewport_rect().size / 2
	# Goi randomize() vi de moi lan open Scene len thi Vat the se di chuyen mot huong khac
	randomize()
	randomDirection()
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y

func randomDirection():
	direction.x = rand_range(-1, 1)
	direction.y = rand_range(-1, 1)

func _process(delta):
	#Moi 3 giay se doi chieu  lan
	accum += delta
	if isTen == false:
		if int(accum) != 0:
			if int(accum) % 2 == 0:
				randomDirection()
				isTen = true
	if int(accum) % 2 != 0:
		isTen = false
	
	# Doi chieu khi va cham vao mep man hinh
	if position.x <= 0 || position.x >= width:
		direction.x = - direction.x
		$HitSound.play()
	if position.y <= 0 || position.y >= height:
		direction.y = - direction.y
		$HitSound.play()
	if direction.length() > 0:
		# dung de Vat the di chuyen trong vong tron co ban kinh nhat dinh
		direction = direction.normalized() * SPEED
	position += direction * delta
	position.x = clamp(position.x, 0, width)
	position.y = clamp(position.y, 0, height)

func _on_UFO_input_event(viewport, event, shape_idx):
	if lose:
		return
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		randomDirection()
		position.x = rand_range(1, width -1)
		position.y = rand_range(1, height -1)
		SPEED += 100
		hit = true
		$HitSound.play()
