extends Area2D

var damage = 16

func _on_area_entered(area):
	if area.is_in_group("player_hitbox"):
		var player = area.owner
		player.hurt(damage)
