extends Area2D

func _on_body_entered(body: Node2D) -> void:
	get_node("/root/Level/Player").entered_bubble()


func _on_body_exited(body: Node2D) -> void:
	get_node("/root/Level/Player").exited_bubble()
