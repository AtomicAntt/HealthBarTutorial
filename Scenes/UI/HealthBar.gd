extends TextureProgressBar

@onready var damage_bar = $DamageBar

var duration = 0.5

func change_value(new_value):
	value = new_value
	
	var tween = get_tree().create_tween()
	tween.tween_property(damage_bar, "value", new_value, duration)
	
