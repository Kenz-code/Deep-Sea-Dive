shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE,UV);
	
	COLOR.a = ceil(COLOR.a)
}
