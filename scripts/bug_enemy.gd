extends CharacterBody2D

@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var second_timer: Timer = $SecondTimer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var collision_shape_2: CollisionShape2D = $DeathArea/CollisionShape2D

@export var patrol_points : Node
@export var speed := 1500.0
@export var wait_time := 3
@export var damage := 1

enum State {
	IDLE,
	MOVE,
	DEATH
}

var direction := Vector2.LEFT
var current_state = State.IDLE
var gravity := 1000.0
var number_of_points : int
var point_positions : Array[Vector2]
var current_point : Vector2
var current_point_position : int
var can_walk : bool

func _ready() -> void:
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol point")
		
	timer.wait_time = wait_time
	
	current_state = State.IDLE
	
func _physics_process(delta: float) -> void:
	idle_state(delta)
	move_state(delta)
	
	enemy_garvity(delta)
	move_and_slide()
	enemy_animations()
	
func enemy_garvity(delta: float):
	velocity.y += gravity * delta

func idle_state(delta: float):
	if !can_walk:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		current_state = State.IDLE

func move_state(delta: float):
	if !can_walk:
		return
		
	if abs(position.x -current_point.x) > 0.5:
		velocity.x = direction.x * speed * delta
		current_state = State.MOVE
	else:
		current_point_position += 1
	
		if current_point_position >= number_of_points:
			current_point_position = 0
	
		current_point = point_positions[current_point_position]
	
		if current_point.x > position.x:
			direction = Vector2.RIGHT
		else:
			direction = Vector2.LEFT
		
		can_walk = false
		timer.start()
	
	animated_sprite.flip_h = direction.x < 0

func death_state():
	queue_free()

func enemy_animations():
	if current_state == State.IDLE && !can_walk:
		animated_sprite.play("idle")
	elif current_state == State.MOVE && can_walk:
		animated_sprite.play("run")
	
func _on_timer_timeout() -> void:
	can_walk = true

func _on_death_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if is_instance_valid(collision_shape):
			collision_shape.queue_free()
	elif body.is_in_group("Interactables"):
		if is_instance_valid(collision_shape):
			collision_shape.queue_free()
		second_timer.start()

func _on_second_timer_timeout() -> void:
	death_state()
