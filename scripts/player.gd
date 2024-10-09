extends CharacterBody2D
class_name Player

var player_death_effect = preload("res://scenes/player_death_effect.tscn")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_animation_player: AnimationPlayer = $HitAnimationPlayer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var platform_detected: RayCast2D = $PlatformDetected


enum {
	MOVE,
	DAMAGE,
	DEATH
}

var gravity := 1000.0
var state = MOVE
var is_on_platform = true
var push_force = 80.0

@export var standart_speed := 300.0
@export var jump_velocity := -400.0

func _physics_process(delta: float) -> void:
	
	match state:
		MOVE:
			move_state()
		DAMAGE:
			pass
		DEATH:
			death_state()
	
	player_gravity(delta)
	move_and_slide()
	pushing_objects()

func player_gravity(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
	
func move_state():
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity
		animated_sprite.play("jump")
		await animated_sprite.animation_finished
		
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * standart_speed
		if velocity.y == 0:
			animated_sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, standart_speed)
		if velocity.y == 0:
			animated_sprite.play("idle")
			
	if direction == -1:
		animated_sprite.flip_h = true
		
	elif direction == 1:
		animated_sprite.flip_h = false
		
func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("down")) and platform_detected.is_colliding():
		collision_shape.disabled = true
		await get_tree().create_timer(0.1).timeout
		collision_shape.disabled = false
	
func death_state():
	var player_death_effect_inctance = player_death_effect.instantiate() as Node2D
	player_death_effect_inctance.global_position = global_position
	get_parent().add_child(player_death_effect_inctance)
	queue_free()
	
func pushing_objects():
	for i in get_slide_collision_count():
		var object = get_slide_collision(i)
		if object.get_collider() is RigidBody2D:
			object.get_collider().apply_central_impulse(-object.get_normal() * push_force)
	
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		hit_animation_player.play("hit")
		HealthManager.decrease_health(body.damage)
	if HealthManager.current_health == 0:
		state = DEATH

func _on_floor_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Traps"):
		hit_animation_player.play("hit")
		HealthManager.decrease_health(body.damage)
	if HealthManager.current_health == 0:
		state = DEATH
