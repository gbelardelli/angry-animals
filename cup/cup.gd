extends StaticBody2D

@onready var animation_player = $AnimationPlayer
@onready var vanish_sound = $VanishSound


func die() -> void:
	print("cup die")
	vanish_sound.play()
	animation_player.play("vanish")
	print("cup end die")
	



func _on_vanish_sound_finished():
	# Questo perchè il suono dura leggermente di più dell'animazione
	# altrimenti poteva essere messo direttamente nella die()
	SignalManager.on_cup_destroyed.emit()
	queue_free()


