extends Node2D

signal hit
signal scored


func _on_hit_area_body_entered(body):
	hit.emit()


func _on_score_area_body_entered(body):
	scored.emit()

func clear():
	self.queue_free()
