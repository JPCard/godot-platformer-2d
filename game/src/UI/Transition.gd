extends ColorRect

signal screen_covered

var _loading_anim_started := false

onready var _animation_player: AnimationPlayer = $AnimationPlayer


# The level transition animations will be fade_outin->[fade_in_extras->
# loading->fade_out_extras->]fade_out
# [fade_in_extras->loading->fade_out_extras->] is optional and its
# length depends on the extra time the LevelLoader takes to load the next level


func start_transition_animation() -> void:
	_animation_player.play("fade_in")


func finish_transition_animation() -> void:
	if _loading_anim_started:
		_animation_player.play("fade_out_extras")
		_loading_anim_started = false
	else:
		_animation_player.play("fade_out")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		emit_signal("screen_covered")
		_animation_player.play("fade_in_extras")
	elif anim_name == "fade_in_extras":
		_loading_anim_started = true
		_animation_player.play("loading")
	elif anim_name == "fade_out_extras":
		_animation_player.play("fade_out")
