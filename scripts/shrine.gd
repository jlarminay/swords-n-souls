extends Area2D

export(NodePath) var target_path;

var target;
var dis;

func _ready():
	target = get_node(target_path);

func _process(delta):
	dis = position.distance_to(target.position);
	if( dis < 150 ):
		target.finished(position);
