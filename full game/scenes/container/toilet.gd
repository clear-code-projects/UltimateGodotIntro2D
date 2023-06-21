extends ItemContainer

func hit():
	if not opened:
		$LidSprite.hide()
		$AudioStreamPlayer2D.play()
		var pos = $SpawnPositions/Marker2D.global_position
		open.emit(pos, current_direction)
		opened = true
