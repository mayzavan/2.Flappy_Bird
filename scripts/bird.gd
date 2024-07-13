extends CharacterBody2D

var GRAVITY = 1500
signal hit
var gamelost
var play
var flap_sp = -6

func _ready():
	$sprite.frame = 1
	gamelost = false
	play = false

func _process(delta):
	if play == true:
		velocity.y += GRAVITY * delta * delta
		position.y += velocity.y
		
		position.y = clamp(position.y,0,534)
		
		if position.y >=534:
			hit.emit()
			gamelost = true
			
		if Input.is_action_just_pressed('flap') and gamelost == false:
			$FlapSFX.play()
			velocity.y = flap_sp
			$sprite.frame = 0
			await get_tree().create_timer(0.15, false).timeout
			$sprite.frame = 1
	elif play == false and Input.is_action_just_pressed('flap'):
		$FlapSFX.play()
		velocity.y = flap_sp
		$sprite.frame = 0
		await get_tree().create_timer(0.15, false).timeout
		$sprite.frame = 1
		play = true
