extends CharacterBody2D

# Variables de velocidad
const WALK_SPEED = 200.0
const RUN_SPEED = 450.0

# Referencias a tus nodos (Asegúrate que se llamen así en la escena)
@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	# 1. Detectar dirección (Izquierda/Derecha)
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# 2. Detectar si corre (Debes tener "correr" configurado en el Mapa de Entradas)
	var esta_corriendo = Input.is_action_pressed("correr")
	
	# 3. Elegir la velocidad
	var velocidad_actual = RUN_SPEED if esta_corriendo else WALK_SPEED

	# 4. Lógica de movimiento y animación
	if direction != 0:
		velocity.x = direction * velocidad_actual
		
		# Voltear el dibujo según la dirección
		sprite.flip_h = (direction < 0)
		
		# Elegir animación
		if esta_corriendo:
			anim.play("Correr")
		else:
			anim.play("Caminar")
	else:
		# Frenado cuando sueltas las teclas
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		anim.play("Idle")

	# Aplicar el movimiento
	move_and_slide()
