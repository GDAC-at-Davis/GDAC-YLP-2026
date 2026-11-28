shader_type canvas_item;
uniform vec4 silhouette_color: source_color;
uniform float transparency = 1.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color = mix(color, silhouette_color, color.a * transparency);
	color.a *= transparency;
	
	COLOR = color;
}
