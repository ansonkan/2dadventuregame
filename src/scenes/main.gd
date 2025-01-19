extends Node

@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Camera2D



func _process(delta: float) -> void:
	camera_2d.position = player.global_position
