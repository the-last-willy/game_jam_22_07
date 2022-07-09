// NOTE: Shader automatically converted from Godot Engine 3.4.4.stable's SpatialMaterial.

shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;
uniform vec4 albedo : hint_color;
uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1);

varying vec3 world_pos;

void vertex() {
	world_pos = (WORLD_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

float random(vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) *
            43758.5453123);
}

float noise(vec2 uv) {
    vec2 uv_index = floor(uv);
    vec2 uv_fract = fract(uv);

    // Four corners in 2D of a tile
    float a = random(uv_index);
    float b = random(uv_index + vec2(1.0, 0.0));
    float c = random(uv_index + vec2(0.0, 1.0));
    float d = random(uv_index + vec2(1.0, 1.0));

    vec2 blur = smoothstep(0.0, 1.0, uv_fract);

    return mix(a, b, blur.x) +
            (c - a) * blur.y * (1.0 - blur.x) +
            (d - b) * blur.x * blur.y;
}

float fbm(vec2 uv) {
    int octaves = 6;
    float amplitude = 1.0;
    float frequency = 0.01;
	float value = 0.0;
	
    for(int i = 0; i < octaves; i++) {
        value += amplitude * noise(frequency * (uv + vec2(TIME * pow(2.0,float(octaves-i)))));
        amplitude *= 0.5;
        frequency *= 2.0;
    }
    return value;
}

void fragment() {
	ALBEDO = albedo.rgb;
	METALLIC = metallic;
	ROUGHNESS = roughness;
	SPECULAR = specular;
	
	float height = fbm(world_pos.xz);
	float amplitude = 100.0;
	vec3 point = vec3(world_pos.x, dFdx(height) * amplitude, world_pos.z);
	vec3 diffx = dFdx(point);
	vec3 diffy = dFdy(point);
	
	NORMAL = normalize(cross(diffx, diffy));
}
