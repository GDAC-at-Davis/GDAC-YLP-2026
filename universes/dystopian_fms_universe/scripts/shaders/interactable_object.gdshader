shader_type canvas_item;

uniform bool is_glowing = false;
uniform bool is_wavering = false;
uniform float glow_amount: hint_range(0, 1) = 0.5;
uniform vec3 glow_color: source_color;
uniform float wavering_range: hint_range(0, 1) = 0.2;
uniform float wavering_speed: hint_range(0, 20) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	if (is_glowing) {
		float color_mod = glow_amount;
		if (is_wavering) {
			color_mod += sin(TIME * wavering_speed) * wavering_range;
		}
		vec3 new_color = vec3((COLOR.r + COLOR.g + COLOR.b) / 3.0); // Make monochrome
		COLOR = vec4(max((new_color + glow_color.rgb) * color_mod, COLOR.rgb), COLOR.a);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
