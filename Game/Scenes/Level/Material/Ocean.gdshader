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

float fade(float t) {
  return t*t*t*(t*(t*6.0 - 15.0) + 10.0);
}

vec2 random_perlin(vec2 uv){
    uv = vec2( dot(uv, vec2(127.1,311.7) ),
               dot(uv, vec2(269.5,183.3) ) );
    return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123);
}
vec3 grad(vec3 p) {
	vec3 v = vec3(random_perlin(p.xy)*random_perlin(p.yz)*random_perlin(p.zx),noise(p.xy));
	
    return normalize(v.xyz*2.0 - vec3(1.0)); /* remap sampled value to [-1; 1] and normalize */
}

vec2 grad_2(vec2 p) {
	vec2 v = random_perlin(p);
    return normalize(v.xy*2.0 - vec2(1.0)); /* remap sampled value to [-1; 1] and normalize */
}

float perlin_noise_2(vec2 p) {
  /* Calculate lattice points. */
  vec2 p0 = floor(p);
  vec2 p1 = p0 + vec2(1.0, 0.0);
  vec2 p2 = p0 + vec2(0.0, 1.0);
  vec2 p3 = p0 + vec2(1.0, 1.0);
  
  /* Look up gradients at lattice points. */
  vec2 g0 = grad_2(p0);
  vec2 g1 = grad_2(p1);
  vec2 g2 = grad_2(p2);
  vec2 g3 = grad_2(p3);
    
  float t0 = p.x - p0.x;
  float fade_t0 = fade(t0); /* Used for interpolation in horizontal direction */

  float t1 = p.y - p0.y;
  float fade_t1 = fade(t1); /* Used for interpolation in vertical direction. */

  /* Calculate dot products and interpolate.*/
  float p0p1 = (1.0 - fade_t0) * dot(g0, (p - p0)) + fade_t0 * dot(g1, (p - p1)); /* between upper two lattice points */
  float p2p3 = (1.0 - fade_t0) * dot(g2, (p - p2)) + fade_t0 * dot(g3, (p - p3)); /* between lower two lattice points */
  
  /* Calculate final result */
  return (1.0 - fade_t1) * p0p1 + fade_t1 * p2p3;
}

float perlin_noise(vec3 p) {
  /* Calculate lattice points. */
  vec3 p0 = floor(p);
  vec3 p1 = p0 + vec3(1.0, 0.0, 0.0);
  vec3 p2 = p0 + vec3(0.0, 1.0, 0.0);
  vec3 p3 = p0 + vec3(1.0, 1.0, 0.0);
  vec3 p4 = p0 + vec3(0.0, 0.0, 1.0);
  vec3 p5 = p4 + vec3(1.0, 0.0, 0.0);
  vec3 p6 = p4 + vec3(0.0, 1.0, 0.0);
  vec3 p7 = p4 + vec3(1.0, 1.0, 0.0);
    
  /* Look up gradients at lattice points. */
  vec3 g0 = grad(p0);
  vec3 g1 = grad(p1);
  vec3 g2 = grad(p2);
  vec3 g3 = grad(p3);
  vec3 g4 = grad(p4);
  vec3 g5 = grad(p5);
  vec3 g6 = grad(p6);
  vec3 g7 = grad(p7);
    
  float t0 = p.x - p0.x;
  float fade_t0 = fade(t0);

  float t1 = p.y - p0.y;
  float fade_t1 = fade(t1);
    
  float t2 = p.z - p0.z;
  float fade_t2 = fade(t2);

  float p0p1 = (1.0 - fade_t0) * dot(g0, (p - p0)) + fade_t0 * dot(g1, (p - p1));
  float p2p3 = (1.0 - fade_t0) * dot(g2, (p - p2)) + fade_t0 * dot(g3, (p - p3));

  float p4p5 = (1.0 - fade_t0) * dot(g4, (p - p4)) + fade_t0 * dot(g5, (p - p5));
  float p6p7 = (1.0 - fade_t0) * dot(g6, (p - p6)) + fade_t0 * dot(g7, (p - p7));

  float y1 = (1.0 - fade_t1) * p0p1 + fade_t1 * p2p3;
  float y2 = (1.0 - fade_t1) * p4p5 + fade_t1 * p6p7;

  return (1.0 - fade_t2) * y1 + fade_t2 * y2;
}

float fbm(vec2 uv) {
    int octaves = 4;
    float amplitude = 2.0;
    float frequency = 0.01;
	float frequency2 = 0.1;
	float value = 0.0;
	
    for(int i = 0; i < octaves; i++) {
      value += amplitude * perlin_noise(vec3(frequency * (uv + vec2(TIME * pow(2.0,float(octaves-i)))),perlin_noise_2(frequency2* (uv + vec2(TIME * pow(1.5,float(octaves-i)))))));
//        value += amplitude * noise(frequency * (uv + vec2(TIME * pow(2.0,float(octaves-i)))));
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
