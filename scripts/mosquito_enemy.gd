extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = $"../Player"
@onready var collision_shape: CollisionShape2D = $DeathZone/CollisionShape2D
@onready var collision_shape_2: CollisionShape2D = $AttackZone/CollisionShape2D
@onready var collision_shape_3: CollisionShape2D = $DetectionZone/CollisionShape2D
@onready var collision_shape_4: CollisionShape2D = $HitZone/CollisionShape2D

enum {
	FLY,
	CHASE,
	ATTACK,
	DEATH
}

@export var damage := 1

var state := FLY
var attack_speed := 200.0
var speed := 100.0
var rotation_speed := 1.1 


func _physics_process(_delta: float) -> void:
	
	match state:
		FLY:
			fly_state()
		CHASE:
			chase_state()
		ATTACK:
			attack_state()
		DEATH:
			death_state()

	move_and_slide()
		
func fly_state():
	collision_shape.disabled = true
	velocity.x = 0
	velocity.y = 0
	animated_sprite.play("fly")

func chase_state():
	animated_sprite.play("fly")
	collision_shape.disabled = true
	var direction = (player.position - self.position).normalized()
	velocity = direction * speed
	flip()	

func attack_state():
	collision_shape.disabled = false
	animated_sprite.play("attack")
	var direction = (player.position - self.position).normalized()
	velocity = direction * attack_speed
	flip()	
	
func death_state():
	velocity.x = 0
	velocity.y = 0
	animated_sprite.play("death")
	await animated_sprite.animation_finished
	collision_shape_4.disabled = true
	collision_shape_3.disabled = true
	collision_shape_2.disabled = true
	queue_free()
	
func flip():
	if velocity.x > 0:
		collision_shape.rotation_degrees = -64
		animated_sprite.flip_h = true
	elif velocity.x < 0:
		collision_shape.rotation_degrees = 0
		animated_sprite.flip_h = false
		
func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		state = CHASE

func _on_detection_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		state = FLY
		
func _on_attack_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		state = ATTACK

func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		state = DEATH
#
func _on_hit_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		state = DEATH
