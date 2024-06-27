shader_type spatial;
render_mode unshaded;
instance uniform float density;
instance uniform float shell_count;
instance uniform float shell_index;
instance uniform float shell_distance;

float hash(vec2 input) {
    vec3 p = fract(input.xyx * 0.1031);
    p += dot(p, p.yzx + 33.33);
    return fract((p.x + p.y) * p.z);
}

void vertex() {
	// Called for every verrender_modetex the material is visible on.
    
	VERTEX += NORMAL * shell_index * shell_distance;
}

void fragment() {
	// Called for every pixel the material is visible on.
	float shell_height = shell_index / (shell_count - 1.0);
    float hash_result = hash(floor(UV * density) + 100.0);

    if (hash_result <= shell_height) {
        discard;
    }

    ALBEDO = vec3(0.0, 1.0, 0.0) * shell_height;
}


void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
}
