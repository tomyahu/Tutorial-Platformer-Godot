extends KinematicBody2D


# Declare member variables here. Examples:
export var velocidad_correr = 100
export var velocidad_salto = -200
export var gravedad = 10
var velocidad_vertical_actual = 0;
var velocidad_horizontal_actual = 0;


# Esta funcion se corre cuando el jugador es creado en la escena
func _ready():
	$AnimatedSprite.play("default")


# Esta funcion se corre en cada frame que el jugador este vivo
func _process(delta):
	# Reiniciamos la velocidad horizontal actual a 0
	velocidad_horizontal_actual = 0
	
	# Si la accion "mover_izquierda" esta apretada, entonces le restamos
	# velocidad_correr a la velocidad horizontal actual para hacer que el
	# jugador se mueva a la izquierda
	if (Input.is_action_pressed("mover_izquierda")):
		velocidad_horizontal_actual = velocidad_horizontal_actual - velocidad_correr
	
	# Si la accion "mover_derecha" esta apretada, entonces le sumamos
	# velocidad_correr a la velocidad horizontal actual para que se detenga si
	# nos estamos moviendo a la izquierda y avance a la derecha si no nos
	# estamos moviendo
	if (Input.is_action_pressed("mover_derecha")):
		velocidad_horizontal_actual = velocidad_horizontal_actual + velocidad_correr
	
	# Si la accion saltar fue apretada recien, y estamos en el suelo. Entonces
	# actualizamos nuestra velocidad vertical para darnos una velocidad de
	# salto.
	#
	# Tambien actualizamos la animacion actual a la animacion de "salto" y
	# hacemos que suente el sonido_salto
	if (Input.is_action_just_pressed("saltar") and is_on_floor()):
		velocidad_vertical_actual = velocidad_salto
		$AnimatedSprite.play("salto")
		$sonido_salto.play()
	
	# Nos movemos utilizando nuestra velocidad horizontal y vertical actuales;
	# y le decimos a godot que el arriba esta en la direccion (0,-1) para poder
	# detectar si estamos tocando el suelo o el techo
	move_and_slide(Vector2(velocidad_horizontal_actual, velocidad_vertical_actual), Vector2(0, -1))
	
	# Si estamos en el suelo entonces hacemos que nuestra velocidad vertical sea
	# 0 y cambiamos nuestra animacion a la animacion default
	if (is_on_floor()):
		velocidad_vertical_actual = 0
		$AnimatedSprite.play("default")
	
	# ESTA PARTE NO ESTABA EN EL TUTORIAL
	# Si estamos tocando el techo entonces hacemos que nuestra velocidad
	# vertical sea 0 para no quedarnos pegados en el techo cuando saltamos
	if (is_on_ceiling()):
		velocidad_vertical_actual = 0
	
	# Actualizamos la velocidad vertical actual dado el valor de gravedad
	velocidad_vertical_actual = velocidad_vertical_actual + gravedad
	
	
	
