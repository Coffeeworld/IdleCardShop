extends Control

func _input(event) -> void:
	if event.is_action_pressed("god_panel"):
		if %GodPanel.visible == false:
			%GodPanel.show()
			%CollectionUi.hide()
		else:
			SignalManager.emit_signal('update_collection_ui')
			%GodPanel.hide()
			%CollectionUi.show()
	else:
		pass
