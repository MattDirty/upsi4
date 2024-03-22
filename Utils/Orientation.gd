
class_name Orientation

const DIRECTIONS = ["East", "South", "West", "North"]
const RAD_360 = deg_to_rad(360)
const DIRECTIONS_SUBDIVION = RAD_360 / 4 # DIRECTIONS.length

## Finds the direction ("East"|"NorthWest"|..) from an angle in radiants
static func get_direction_from_angle(rad_angle: float):
	rad_angle += DIRECTIONS_SUBDIVION / 2
	if rad_angle < 0:
		rad_angle += RAD_360
	return DIRECTIONS[rad_angle / DIRECTIONS_SUBDIVION]
