extends CharacterBody2D

const DIVE_SPEED = 750
const KNOCKBACK = 350
const HIT_KNOCKBACK = 350

var gravity = 100
var max_gravity = 125

var is_diving = false
var is_dead = false

var invincable = false

var can_move = true
var can_control = true

var dash_sfx = ["res://SFX/Player_Dash_01.mp3", "res://SFX/Player_Dash_02.mp3", "res://SFX/Player_Dash_03.mp3"]
var bubble_sfx = ["res://SFX/Player_Bubble_01.mp3", "res://SFX/Player_Bubble_02.mp3", "res://SFX/Player_Bubble_03.mp3", "res://SFX/Player_Bubble_04.mp3", "res://SFX/Player_Bubble_05.mp3", "res://SFX/Player_Bubble_06.mp3"]
var death_sfx = ["res://SFX/Player_Death_01.mp3", "res://SFX/Player_Death_02.mp3", "res://SFX/Player_Death_03.mp3"]
var hurt_sfx = ["res://SFX/Player_Hurt_01.mp3", "res://SFX/Player_Hurt_02.mp3", "res://SFX/Player_Hurt_03.mp3"]

signal hearts_changed(hearts)

func _ready():
	get_parent().get_node("UI/Control/TimerBarComponent").timer = $DiveCooldown
	
	hearts_changed.connect($CanvasLayer/Hearts._on_hearts_changed)

func _physics_process(delta):
	var direction = Input.get_axis("left","right")
	if can_control:
		if direction:
			velocity.x = direction * $VelocityComponent.speed
			velocity.y = move_toward(velocity.y, gravity, $VelocityComponent.decel)
		else:
			velocity.x = move_toward(velocity.x, 0, $VelocityComponent.decel)
			velocity.y = move_toward(velocity.y, gravity, $VelocityComponent.decel)
		
		if Input.is_action_just_pressed("dive") and can_move:
			dive()
	
	assign_animation(direction)
	Global.camera.global_position.y = 0
	
	if is_dead:
		velocity.x = move_toward(velocity.x, 0, $VelocityComponent.decel)
		velocity.y += 10
		$Sprite2D.rotation_degrees += 6
	
	if can_move:
		move_and_slide()

func dive():
	if $DiveCooldown.time_left > 0:
		return
	
	velocity.y += DIVE_SPEED
	$DiveP.restart()
	$DiveP2.restart()
	
	#sfx
	$DashSFX.stream = load(dash_sfx[randi() % dash_sfx.size()])
	$DashSFX.play()
	
	$DiveCooldown.start()
	Global.camera.shake(25, 0.8)
	
	await $DiveCooldown.timeout

func assign_animation(direction):
	if is_dead:
		return
	if velocity.y > max_gravity + 15:
		#dive
		$AnimationPlayer.play("dive")
		is_diving = true
		$DiveLineP.emitting = true
	else:
		is_diving = false
		$DiveLineP.emitting = false
		if direction == 1:
			$AnimationPlayer.play("right_swim")
			$Sprite2D.scale.x = -3
		elif direction == -1:
			$AnimationPlayer.play("left_swim")
			$Sprite2D.scale.x = 3
		else:
			$AnimationPlayer.play("down_swim")

func start_invincable():
	invincable = true
	$InvincableTimer.start()
	$Hurtbox_Component.set_deferred("monitoring",false)
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	for i in range(3):
		tween.tween_property(self, "modulate", Color(1,1,1,0), 0.5)
		tween.tween_property(self, "modulate", Color(1,1,1,1), 0.5)
	
	await $InvincableTimer.timeout
	invincable = false
	$Hurtbox_Component.set_deferred("monitoring",true)

func _on_hitbox_component_body_hit(body):
	if is_diving == true and body.is_in_group("enemy"):
		body.die()
		velocity.y = -HIT_KNOCKBACK
		$DiveCooldown.stop()
		Global.camera.shake(25)
		is_diving = false
		


func _on_hurtbox_component_body_hit(body):
	var kb_dir = global_position.direction_to(body.global_position)
	velocity += -kb_dir * KNOCKBACK
	
	hearts_changed.emit($Health.health)
	
	$HurtSFX.stream= load(hurt_sfx[randi() % hurt_sfx.size()])
	$HurtSFX.play()
	$HeartBreakSFX.play()
	
	if $Health.health == 0:
		die()
		$DeathSFX.stream = load(death_sfx[randi() % death_sfx.size()])
		$DeathSFX.play()
		$Hurtbox_Component.set_deferred("monitoring",false)
	else:
		start_invincable()

func reset_dive_cooldown():
	$DiveCooldown.stop()

func die():
	Global.camera.follow_player = false
	
	can_control = false
	is_dead = true
	$CollisionShape2D.set_deferred("disabled", true)
	
	var target_pos = global_position.y + 800
	
	$AnimationPlayer.stop()
	
	await get_tree().create_timer(3).timeout
	SceneManager.change_scene("res://Scenes/DieMenu/die_menu.tscn", Global.custom_scene_change)


func _on_bubble_timer_timeout():
	$BubbleSFX.stream = load(bubble_sfx[randi() % bubble_sfx.size()])
	$BubbleSFX.play()
