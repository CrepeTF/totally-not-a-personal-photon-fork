#ifndef INCLUDE_LIGHT_LPV_FLOODFILL
#define INCLUDE_LIGHT_LPV_FLOODFILL

#include "voxelization.glsl"
#include "/include/light/lpv/light_colors.glsl"

// Precompute constants
const uint EMITTER_MIN = 32u, EMITTER_MAX = 64u;
const uint TRANSLUCENT_MIN = 164u, TRANSLUCENT_MAX = 180u;
const uint CUSTOM_MIN = 64u, CUSTOM_MAX = 96u;
const uint CANDLE_MIN = 264u, CANDLE_MAX = 332u;

#define IS_IN_RANGE(x, min, max) ((x) >= (min) && (x) < (max))

float get_candle_intensity(uint level) {
    return float(level * level + 2u);
}

vec3 get_emitted_light(uint block_id) {
    if (IS_IN_RANGE(block_id, EMITTER_MIN, EMITTER_MAX)) {
        return texelFetch(light_data_sampler, ivec2(int(block_id) - 32, 0), 0).rgb;
    } else if (IS_IN_RANGE(block_id, CUSTOM_MIN, CUSTOM_MAX)) {
        return light_color[block_id - 32u];
    } else if (IS_IN_RANGE(block_id, CANDLE_MIN, CANDLE_MAX)) {
        uint adjusted_id = block_id - CANDLE_MIN;
        uint level = adjusted_id >> 4u;
        float intensity = get_candle_intensity(level);
        return (block_id > 327u) ? light_color[18u] * (0.125 * intensity) : tint_color[adjusted_id & 15u] * intensity;
    }
    return vec3(0.0);
}

vec3 get_tint(uint block_id, bool is_transparent) {
    return IS_IN_RANGE(block_id, TRANSLUCENT_MIN, TRANSLUCENT_MAX)
        ? texelFetch(light_data_sampler, ivec2(int(block_id) - 164, 1), 0).rgb
        : vec3(float(is_transparent));
}

vec3 gather_light(sampler3D light_sampler, ivec3 pos) {
    const ivec3 offsets[7] = ivec3[7](
        ivec3(0), ivec3(1,0,0), ivec3(-1,0,0),
        ivec3(0,1,0), ivec3(0,-1,0), ivec3(0,0,1), ivec3(0,0,-1)
    );
    
    vec3 sum = vec3(0.0);
    for (int i = 0; i < 7; ++i) {
        sum += texelFetch(light_sampler, clamp(pos + offsets[i], ivec3(0), voxel_volume_size - 1), 0).rgb;
    }
    return sum * (1.0 / 7.0);
}

void update_lpv(writeonly image3D light_img, sampler3D light_sampler) {
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    ivec3 previous_pos = ivec3(vec3(pos) - floor(previousCameraPosition) + floor(cameraPosition));

    uint block_data = texelFetch(voxel_sampler, pos, 0).x;
    bool transparent = (block_data == 0u) || (block_data >= 1024u);
    uint block_id = block_data & 1023u;

    vec3 light_avg = gather_light(light_sampler, previous_pos);
    vec3 emitted_light = get_emitted_light(block_id);
    emitted_light *= abs(emitted_light);
    vec3 tint = get_tint(block_id, transparent);
    tint *= tint;

    vec3 light = emitted_light + light_avg * tint;

    imageStore(light_img, pos, vec4(light, 0.0));
}

#endif // INCLUDE_LIGHT_LPV_FLOODFILL
