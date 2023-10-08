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
func dragStart(_startPos: Vector2):
	pass

##
func dragging(_startPos: Vector2, _currentPos: Vector2):
	pass

##
func dragEnd(_startPos: Vector2, _endPos: Vector2):
	pass

##
func selectionDragStart(_startPos: Vector2):
	pass

##
func selectionDragging(_startPos: Vector2, _currentPos: Vector2):
	pass

##
func selectionDragEnd(_startPos: Vector2, _endPos: Vector2):
	pass
