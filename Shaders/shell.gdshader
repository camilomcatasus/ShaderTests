shader_type spatial;
render_mode unshaded;

struct VertexData {
	vec4 vertex;
	vec3 norma;
};

instance uniform uint shell_index;
instance uniform uint shell_count;
instance uniform float shell_length;
instance uniform float density;
instance uniform float noise_min;
instance uniform float noise_max;
instance uniform float thickness;
instance uniform float attenuation;
instance uniform float occlusion_bias;
instance uniform float shell_distance_attenuation;
instance uniform float curvature;
instance uniform float displacement_strength;
instance uniform vec3 shell_color;
instance uniform vec3 shell_direction;
instance uniform vec3 light_direction;

varying vec3 world_normal;
varying vec3 world_pos;
varying vec3 pos;
varying vec2 uv;

float hash(uint num) {
	num = num << uint(13) ^ uint(2);
	num = num * (num * num * uint(15731) + uint(789221)) + uint(1376312589);
	float t = float(num & uint(0x7fffffff));
	return float(1) - (t / float(1073741824));
}


void vertex() {
	float shell_height = float(shell_index) / float(shell_count);
	shell_height = pow(shell_height, shell_distance_attenuation);
	
	VERTEX.xyz += NORMAL.xyz * shell_length * shell_height;
	
	vec3 normals = normalize((MODELVIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
	world_normal = normalize((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
	
	float k = pow(shell_height, curvature);
	
	//VERTEX.xyz += shell_direction * k * displacement_strength;
	
	world_pos = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	pos = (PROJECTION_MATRIX * vec4(VERTEX, 1.0)).xyz;
}	

void fragment() {
	vec2 new_uv = UV * density;
	vec2 local_uv = (new_uv - floor(new_uv)) * 2.0 - 1.0;
	float local_distance_from_center = length(local_uv);
	
	uvec2 tid = uvec2(new_uv);
	uint seed = tid.x + uint(100) * tid.y + uint(1000);
	
	float local_shell_index = float(shell_index);
	float local_shell_count = float(shell_count);
	
	float rand = mix(noise_min, noise_max, hash(seed));
	
	float h = local_shell_index / local_shell_count;
	bool outside_thickness = local_distance_from_center > (thickness * (rand - h));

	if (outside_thickness && shell_index > uint(0)) discard;
	
    float light_dot = clamp(dot(world_normal, light_direction), 0.0, 1.0);
	float half_lambert = light_dot * 0.5 + 0.5;

    half_lambert *= half_lambert;

    float ambient_occlusion = pow(h, attenuation);
    ambient_occlusion += occlusion_bias;
    ambient_occlusion = clamp(ambient_occlusion, 0.0, 1.0);
	
	ALBEDO = shell_color * half_lambert * ambient_occlusion ;
	
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
