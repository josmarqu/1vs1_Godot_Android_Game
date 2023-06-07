extends RigidBody2D

var slot_number = 1
onready var particle_slot = $"../PuckParticles/PuckParticles1"

func _integrate_forces(state):
	if state.linear_velocity.length() > 2000:
		state.linear_velocity *= 2000 / state.linear_velocity.length()

func _on_Puck_body_entered(body):
	$ImpactSound.play()
	select_particle_slot()
	particle_slot.position = position
	particle_slot.direction = -linear_velocity
	particle_slot.angular_velocity = angular_velocity
	if body.name == "Blue":
		particle_slot.color = Color(0.5, 0.75, 1.0, 0.5)
	elif body.name == "Red":
		particle_slot.color = Color(1.0, 0.5, 0.5, 0.5)
	else:
		particle_slot.color = Color(1.0, 1.0, 1.0, 0.5)
	particle_slot.emitting = true

func select_particle_slot():
	for _i in range(20):
		if particle_slot.emitting:
			if slot_number == 20:
				particle_slot = $"../PuckParticles/PuckParticles1"
				slot_number = 1
			else:
				slot_number += 1
				particle_slot = get_node("../PuckParticles/PuckParticles" + str(slot_number))
