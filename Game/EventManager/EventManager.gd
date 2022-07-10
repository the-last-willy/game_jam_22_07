extends Node

#class Event:
#	var description : String = ""
#	var lift : float = 0
#	var anger : float = 0
#	var fear : float =  0

var event_min_occurence : float = 20
var event_max_occurence : float = 30

var event_current_delta : float = 10

var event_to_be_played : Dictionary
var current_events = Events.new().events
# Called when the node enters the scene tree for the first time.
func _ready():
	var first_event : Dictionary = {}
	first_event.description = "The plane is currently experiencing a fuel loss.\nPlease regain your seats and keep calm."
	first_event.lift = -10
	first_event.anger = 5
	first_event.fear = 20
	
	event_to_be_played = first_event
	event_current_delta = 0


func init_new_event() -> void:
	var event_id = randi() % current_events.size()
	event_to_be_played = current_events[event_id]
	current_events.pop_at(event_id)
	event_current_delta = rand_range(event_min_occurence, event_max_occurence)

func trigger_current_event():
	print(event_to_be_played.description)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if event_current_delta <= 0:
		trigger_current_event()
		init_new_event()
	else:
		event_current_delta -= delta
