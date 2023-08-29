extends CharacterBody2D

const DIVE = 600

var damage_points = 1

var gravity = 100

var can_dive = true

var death_sfx = ["res://SFX/NPC_Squid_Death_01.mp3", "res://SFX/NPC_Squid_Death_02.mp3", "res://SFX/NPC_Squid_Death_03.mp3"]

func _physics_process(_delta):
	velocity.y = move_toward(velocity.y, gravity, $VelocityComponent.decel)
	velocity.x = move_toward(velocity.x, 0, $VelocityComponent.decel)
	
	for ray in $Rays.get_children():
		if !ray.is_colliding() and can_dive:
			var direction = Vector2(0,0).direction_to(ray.target_position)
			velocity += direction * DIVE
			
			can_dive = false
			$Timer.wait_time = randf_range(1,2.5)
			$Timer.start()
			
	
	_assign_animation()
	move_and_slide()

func _assign_animation():
	if velocity.y > 0:
		$Sprite2D.frame = 0
	else:
		$Sprite2D.frame = 1

func _on_timer_timeout():
	can_dive = true


func die():
	$CollisionShape2D.set_deferred("disabled",true)
	set_physics_process(false)
	$DieP.restart()
	$DieP2.restart()
	$Sprite2D.hide()
	
	$DeathSFX.stream = load(death_sfx[randi() % death_sfx.size()])
	$DeathSFX.play()
	
	var p= load("res://Objects/pearl/pearl.tscn")
	for i in range(2):
		var pearl = p.instantiate()
		pearl.type = pearl.Types.PURPLE
		pearl.position = position
		if i == 0:
			pearl.linear_velocity.x = 20
		else:
			pearl.linear_velocity.x = -20
		get_parent().call_deferred("add_child",pearl)
	
	await get_tree().create_timer(0.5).timeout
	
	queue_free()
