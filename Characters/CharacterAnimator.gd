## The SpriteFrames used for this animation.
## They have to contain "Idle", "Move" and "Attack" as Actions
## For each Action they have to contain the 8 directions
## Naming should be as follow: ["Action"]["North"|"South"|""]["East"|"West"|""]
## Example: MoveSouthWest
class_name CharacterAnimator extends AnimatedSprite2D


func changeAnimation(action: String, direction: String):
	var current_animation = self.get_animation()
	var current_frame = 0
	var current_progress = 0.0
	if action != "Attack" or "Attack" in current_animation:
		current_frame = self.get_frame()
		current_progress = self.get_frame_progress()
	if "Attack" in current_animation\
		and current_frame < self.get_sprite_frames().get_frame_count(current_animation) - 1:
		action = "Attack"
	self.play(action + direction)
	self.set_frame_and_progress(current_frame, current_progress)
