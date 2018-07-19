extends Node2D

var hit = false

func _ready():
	$LoseLabel.hide()

func _process(delta):
	if $UFO.hit == false and hit == true:
		print("lose")
		$UFO.lose = true
		$LoseLabel.show()
	if $UFO.hit == true:
		$UFO.click += 1
		$ClickLabel.text = "Click: " + str($UFO.click) + " -: " + str($UFO.accum)
	$UFO.hit = false
	hit = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		hit = true
