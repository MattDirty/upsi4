extends Area2D

func _process(_delta):
	deal_with_overlap()

func deal_with_overlap():
	if has_overlapping_areas():
		print_debug("ready")
