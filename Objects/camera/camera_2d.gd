extends Camera2D


@onready var shakeTimer = $Timer

var shake_amount = 0
@export var default_offset = Vector2()

var previous_player_pos = Vector2.ZERO
var follow_player = true

func _enter_tree():
	Global.camera = self

func _ready():
	set_process(false)


func _process(delta):
	offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount)) * delta + default_offset

func _physics_process(_delta):
	if follow_player:
		position.y = get_parent().get_node("Player").position.y
		previous_player_pos.y = position.y
	else:
		position.y = previous_player_pos.y


func shake(new_shake, shake_time=0.8, shake_limit=50):
	shake_amount += new_shake
	if shake_amount > shake_limit:
		shake_amount = shake_limit
	
	shakeTimer.wait_time = shake_time
	
	set_process(true)
	shakeTimer.start()

func _on_timer_timeout():
	shake_amount = 0
	set_process(false)
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "offset", default_offset,0.1)
