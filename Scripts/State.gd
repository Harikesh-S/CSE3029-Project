# Virtual base class for all states.
class_name State
extends Node

# Reference to the state machine, to call its `transition_to()` method directly.
# That's one unorthodox detail of our state implementation, as it adds a dependency between the
# state and the state machine objects, but we found it to be most efficient for our needs.
# The state machine node will set it.
var stateMachine = null


# Virtual function. Receives events from the `_unhandled_input()` callback.
func HandleInput(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func Update(_delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func PhysicsUpdate(_delta: float) -> void:
	pass


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func Enter(_msg := {}) -> void:
	pass


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func Exit() -> void:
	pass

