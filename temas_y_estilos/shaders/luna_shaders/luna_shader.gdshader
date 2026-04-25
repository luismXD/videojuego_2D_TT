shader_type canvas_item;

uniform float glow_radius : hint_range(0.0, 1.0) = 0.35;
uniform float glow_intensity : hint_range(0.0, 5.0) = 1.8;
uniform vec4 glow_color : source_color = vec4(1.0, 0.95, 0.7, 1.0);

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    
    // Distancia desde el centro
    vec2 center = vec2(0.5, 0.5);
    float dist = distance(UV, center);
    
    // Halo que se desvanece desde el borde de la luna
    float halo = smoothstep(glow_radius + 0.3, glow_radius, dist);
    halo *= (1.0 - tex.a); // solo aparece donde no hay textura (fuera de la luna)
    
    // Mezcla el halo con la textura original
    vec4 result = tex + glow_color * halo * glow_intensity;
    COLOR = result;
}