extends RemoteTransform2D


export(float) var remote_opacity = 1.0 setget set_remote_opacity


# Remote node cache. I can't access the
# cached remote node from here. It must not be exposed.
var remote_node:CanvasItem


func set_remote_opacity(value):
	if remote_node == null or remote_node.get_path() != remote_path:
		remote_node = get_node(remote_path)
		
	remote_node.modulate.a = value
