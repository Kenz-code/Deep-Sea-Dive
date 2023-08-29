extends CharacterBody2D

var direction = 1
var damage_points = 1

var death_sfx = ["res://SFX/NPC_Fish_Death_01.mp3", "res://SFX/NPC_Fish_Death_02.mp3", "res://SFX/NPC_Fish_Death_03.mp3"]
var type = 0

func _ready():
	type = randi_range(0,1)
	if type == 1:
		$CollisionShape2D.shape.height = 54
		$Sprite2D.texture = load("res://Art/nemo_spritesheet.png")
	elif type == 0:
		$DieP.color_initial_ramp = load("res://Objects/tilemap_part/3.tres")
		$DieP2.color_initial_ramp = load("res://Objects/tilemap_part/3.tres")

func _physics_process(_delta):
	velocity.x = direction * $VelocityComponent.speed
	move_and_slide()
	
	if is_on_wall():
		direction = -direction
		$Sprite2D.flip_h = not $Sprite2D.flip_h

func die():
	$CollisionShape2D.set_deferred("disabled",true)
	set_physics_process(false)
	$DieP.restart()
	$DieP2.restart()
	$Sprite2D.hide()
	
	$DeathSFX.stream = load(death_sfx[randi() % death_sfx.size()])
	$DeathSFX.play()
	
	var p= load("res://Objects/pearl/pearl.tscn")
	var pearl = p.instantiate()
	pearl.position = position
	
	if type == 0:
		pearl.type = pearl.Types.BLUE
	
	get_parent().call_deferred("add_child",pearl)
	
	await get_tree().create_timer(0.5).timeout
	
	queue_free()
