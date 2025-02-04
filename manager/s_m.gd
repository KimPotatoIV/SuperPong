extends Node

##################################################
var audio_player: AudioStreamPlayer2D

var hit_audio_stream = preload("res://sounds/maou_se_system44.wav")
var out_audio_stream = preload("res://sounds/maou_se_onepoint33.wav")

##################################################
func _ready() -> void:
	audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)

##################################################
func hit_audio_play() -> void:
	audio_player.stream = hit_audio_stream
	audio_player.play()

##################################################
func out_audio_play() -> void:
	audio_player.stream = out_audio_stream
	audio_player.play()
