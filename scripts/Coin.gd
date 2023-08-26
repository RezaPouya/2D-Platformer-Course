extends Node2D


func _ready():
	# area_entered is a signal , self , then call "on_area_entered"
	$Area2D.connect("area_entered" , self , "on_area_entered")

func on_area_entered(area2d):
	$AnimationPlayer.play("pickup")
	call_deferred("disable_pickup")
	#queue_free() # in next frame , remove the node 
	
func disable_pickup():
	$Area2D/CollisionShape2D.disabled = true 
#func _process(delta):
#	pass
 
