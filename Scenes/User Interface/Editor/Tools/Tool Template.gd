extends Button

var viewport: Viewport
var tool_name: String = ''
var shortcut_key = ''

##
func clicked():
	pass

##
func selected():
	pass

func mouse_moved():
	pass

##
func unselected():
	pass

##
func dragStart(startPos: Vector2):
	pass

##
func dragging(startPos: Vector2, currentPos: Vector2):
	pass

##
func dragEnd(startPos: Vector2, endPos: Vector2):
	pass

##
func selectionDragStart(startPos: Vector2):
	pass

##
func selectionDragging(startPos: Vector2, currentPos: Vector2):
	pass

##
func selectionDragEnd(startPos: Vector2, endPos: Vector2):
	pass
