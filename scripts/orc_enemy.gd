extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = $"../Player"
@onready var collision_shape_2d_2: CollisionShape2D = $CollisionShape2D2

enum {IDLE, CHASE, ATTACK}

var state : int = 0:
	set(value):
		state = value

var damage := 1
var speed := 200.0
var gravity := 1000.0
			
func _ready() -> void:
	state = IDLE
	
func _physics_process(delta: float) -> void:
	enemy_garvity(delta)
	state_switch()
	move_and_slide()			
	
func enemy_garvity(delta: float):
	velocity.y += gravity * delta
	
func state_switch():
		match state:
			IDLE:
				idle_state()
			#CHASE:
				#chase_state()
			ATTACK:
				attack_state()

func idle_state():
	animated_sprite.play("idle")
	velocity.x = 0
	
#func chase_state():
	#animated_sprite.play("move")
	#
	#var direction = (player.global_position - self.global_position).normalized()
	#velocity.x = direction.x * speed
	#
	#if direction.x > 0:
		#animated_sprite.flip_h = true
	#elif direction.x < 0:
		#animated_sprite.flip_h = false

func attack_state():
	animated_sprite.play("attack")
	
	
#func _on_fallowing_area_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Player"):
		#state = CHASE

func _on_fallowing_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		state = IDLE

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		state = ATTACK

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		state = IDLE
