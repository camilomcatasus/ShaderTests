shader_type spatial;

varying vec4 out_color;
void vertex() {
	// Called for every vertex the material is visible on.
	vec3 pos = normalize(VERTEX.xyz);
	out_color = vec4(pos, 1);
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO.rgb =  out_color.xyz;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
