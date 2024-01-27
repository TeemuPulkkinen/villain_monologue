@icon("./assets/responses_menu.svg")

## A VBoxContainer for dialogue responses provided by [b]Dialogue Manager[/b].
class_name DialogueResponsesMenu extends VBoxContainer


const DialogueResponse = preload("./dialogue_response.gd")


## Emitted when a response is selected.
signal response_selected(response: DialogueResponse)


## Optionally specify a control to duplicate for each response
@export var response_template: Control

# The list of dialogue responses.
var _responses: Array = []


func _ready() -> void:
	visibility_changed.connect(func():
		if visible and get_menu_items().size() > 0:
			get_menu_items()[0].grab_focus()
	)

	if is_instance_valid(response_template):
		response_template.hide()


## Set the list of responses to show.
func set_responses(next_responses: Array) -> void:
	_responses = next_responses


	# EDITED RESPONSE BUBBLES
	if _responses.size() > 0:
		for i in range (0, _responses.size()):
			var thought_bubble = get_child(i)

			var path = "res://art/option_icons/option_"+_responses[i].text+".png"
			var texturefile = FileAccess.open(path, FileAccess.READ)
			if texturefile:
				thought_bubble.image= load(path)
				texturefile.close()
			else:
				thought_bubble.image= load("res://art/option_icons/option_placeholder.png")
				texturefile.close()
			
			thought_bubble.set_meta("response", _responses[i])

		_configure_focus()


# Prepare the menu for keyboard and mouse navigation.
func _configure_focus() -> void:
	var items = get_menu_items()
	for i in items.size():
		var item: Control = items[i]

		item.focus_mode = Control.FOCUS_ALL

		item.focus_neighbor_left = item.get_path()
		item.focus_neighbor_right = item.get_path()

		if i == 0:
			item.focus_neighbor_top = item.get_path()
			item.focus_previous = item.get_path()
		else:
			item.focus_neighbor_top = items[i - 1].get_path()
			item.focus_previous = items[i - 1].get_path()

		if i == items.size() - 1:
			item.focus_neighbor_bottom = item.get_path()
			item.focus_next = item.get_path()
		else:
			item.focus_neighbor_bottom = items[i + 1].get_path()
			item.focus_next = items[i + 1].get_path()

		item.mouse_entered.connect(_on_response_mouse_entered.bind(item))
		item.gui_input.connect(_on_response_gui_input.bind(item, item.get_meta("response")))

	items[0].grab_focus()


## Get the selectable items in the menu.
func get_menu_items() -> Array:
	var items: Array = []
	for child in get_children():
		if not child.visible: continue
		if "Disallowed" in child.name: continue
		items.append(child)

	return items


### Signals


func _on_response_mouse_entered(item: Control) -> void:
	if "Disallowed" in item.name: return

	item.grab_focus()


func _on_response_gui_input(event: InputEvent, item: Control, response: DialogueResponse) -> void:
	if "Disallowed" in item.name: return

	get_viewport().set_input_as_handled()

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		response_selected.emit(response)
	elif event.is_action_pressed("ui_accept") and item in get_menu_items():
		response_selected.emit(response)
