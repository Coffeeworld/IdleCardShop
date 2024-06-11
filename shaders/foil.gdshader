shader_type canvas_item;

uniform vec2 u_resolution;
uniform vec2 u_mouse;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = vec4(UV.x,UV.y,abs(sin(TIME)),0.5);
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
