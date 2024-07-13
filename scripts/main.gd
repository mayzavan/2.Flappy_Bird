extends Node

@export var wall_scene: PackedScene
var walls: Array
var score
var game_lost
var scroll
var scroll_sp
var screen_size
var play
var hardened

func _ready():
	hardened = true
	scroll_sp = 4
	scroll = 0
	score = 0
	$gameover.hide()
	game_lost = false
	screen_size = get_window().size
	play = false

func _process(delta):
	if play == true:
		if game_lost == false:
			scroll += scroll_sp
			if scroll >= screen_size.x:
				scroll = 0
			$floor.position.x =- scroll
			for wall in walls:
				wall.position.x -= scroll_sp
				
				$Score.text = (str(score))
			
		if game_lost == true and Input.is_action_just_pressed("flap"):
			restart_game()
	elif play == false and Input.is_action_just_pressed("flap"):
		play = true
	if score%10 == 0 and !hardened:
		scroll_sp += 1
		hardened = true


func _on_spawner_timeout():
	var wall = wall_scene.instantiate()
	wall.position.x = 1000
	wall.position.y = 250 + randi_range(-150, 150)
	wall.hit.connect(bird_hit)
	wall.scored.connect(bird_scored)
	add_child(wall)
	walls.append(wall)

func bird_hit():
	if game_lost == false:
		$HitSFX.play()
		$gameover.show()
		game_lost = true

func bird_scored():
	$ScoreSFX.play()
	score += 1
	hardened = false

func restart_game():
	game_lost = false
	$bird.gamelost = false
	score = 0
	$gameover.hide()
	for wall in walls:
		wall.clear()
	walls.clear()
	$bird.position.y = 300
