extends KinematicBody2D

var speed = 250
var vidas = 100
var tesouros = 0
var interactDist = 80
var vel = Vector2()
var facingDir = Vector2()
var meuxp = 10
onready var raycast = $RayCast2D
onready var anim = $AnimatedSprite

signal criabomba

func _ready():
	pass

func _physics_process(delta):
	vel = Vector2()
	if Input.is_action_pressed("ui_up"):
		vel.y -= 1
		facingDir = Vector2(0,-1)
	if Input.is_action_pressed("ui_down"):
		vel.y += 1
		facingDir = Vector2(0,1)
	if Input.is_action_pressed("ui_left"):
		vel.x -= 1
		facingDir = Vector2(-1,0)
	if Input.is_action_pressed("ui_right"):
		vel.x += 1
		facingDir = Vector2(1,0)
	vel = vel.normalized()
	move_and_slide(vel * speed, Vector2.ZERO)
	
	if Input.is_action_just_pressed("poebomba") and meuxp >= 10:
		toma_xp(-10)
		emit_signal("criabomba")
	
	if vel.x > 0:
		play_animation("direita")
	elif vel.x < 0:
		play_animation("esquerda")
	elif vel.y < 0:
		play_animation("cima")
	elif vel.y > 0:
		play_animation("baixo")
	elif facingDir.x == 1:
		play_animation("pdireita")
	elif facingDir.x == -1:
		play_animation("pesquerda")
	elif facingDir.x == -1:
		play_animation("pcima")
	elif facingDir.y == 1:
		play_animation("pbaixo")
	
func play_animation(anim_name):
	if anim.animation != anim_name:
		anim.play(anim_name)

func toma_tesouro(achado):
	tesouros += achado
	
func toma_xp(quanto):
	meuxp += quanto

func toma_dano(dano):
	vidas -= dano
	if vidas <= 0:
		morre()
		
func morre():
	get_tree().reload_current_scene()

func rety():
	return position.y
	
func retx():
	return position.x
