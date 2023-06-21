extends PathFollow2D

var player_near: bool = false

@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D

@onready var gun_fire1: Sprite2D = $Turret/GunFire1
@onready var gun_fire2: Sprite2D = $Turret/GunFire2

func fire():
	Globals.health -= 20
	gun_fire1.modulate.a = 1
	gun_fire2.modulate.a = 1
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(gun_fire1, "modulate:a",0, randf_range(0.1,0.5))
	tween.tween_property(gun_fire2, "modulate:a",0, randf_range(0.1,0.5))


func _ready():
	line2.add_point($Turret/RayCast2D2.target_position)


func _process(delta):
	progress_ratio += 0.02 * delta
	if player_near:
		$Turret.look_at(Globals.player_pos)
	

func _on_notice_area_body_entered(_body):
	player_near = true
	$AnimationPlayer.play("laser_load")

func _on_notice_area_body_exited(_body):
	player_near = false
	$AnimationPlayer.pause()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(line1, "width", 0 , randf_range(0.1,0.5))
	tween.tween_property(line2, "width", 0 , randf_range(0.1,0.5))
	await tween.finished
	$AnimationPlayer.stop()
