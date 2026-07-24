extends Control




func _on_quit_btn_pressed() -> void:
	get_tree().quit()



func _on_about_pressed() -> void:
	get_tree().change_scene_to_file("res://ui scence/about us.tscn")




func _on_play_game_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/test.tscn")
