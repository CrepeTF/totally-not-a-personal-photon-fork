#ifndef INCLUDE_MISC_WEATHER
#define INCLUDE_MISC_WEATHER

#include "/include/utility/color.glsl"
#include "/include/utility/random.glsl"

#define daily_weather_blend(weather_function) mix(weather_function(worldDay), weather_function(worldDay + 1), weather_mix_factor())

uint weather_day_index(int world_day) {
	// Start at noon
	world_day -= int(worldTime <= 6000);

	const uint day_count = 12;

#if WEATHER_DAY == -1
	uint day_index = uint(world_day);
	     day_index = lowbias32(day_index) % day_count;
#else
	uint day_index = WEATHER_DAY;
#endif

	return day_index;
}

float weather_mix_factor() {
	return cubic_smooth(fract(float(worldTime) * rcp(24000.0) - 0.25));
}

float daily_weather_fogginess(int world_day) {
	const float[] fogginess = float[12](WEATHER_D0_FOGGINESS, WEATHER_D1_FOGGINESS, WEATHER_D2_FOGGINESS, WEATHER_D3_FOGGINESS, WEATHER_D4_FOGGINESS, WEATHER_D5_FOGGINESS, WEATHER_D6_FOGGINESS, WEATHER_D7_FOGGINESS, WEATHER_D8_FOGGINESS, WEATHER_D9_FOGGINESS, WEATHER_D10_FOGGINESS, WEATHER_D11_FOGGINESS);

	return fogginess[weather_day_index(world_day)];
}

// Clouds

#ifdef WEATHER_CLOUDS
void daily_weather_clouds(
	int world_day,
	out vec2 clouds_cumulus_coverage,
	out vec2 clouds_altocumulus_coverage,
	out float clouds_cirrus_coverage,
	out float clouds_cumulus_congestus_amount,
	out float clouds_stratus_amount
) {
	const uint day_count = 12;

	uint day_index = weather_day_index(world_day);

	switch (day_index) {
	case 0:
		clouds_cumulus_coverage         = vec2(WEATHER_D0_CLOUDS_CUMULUS_MIN, WEATHER_D0_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D0_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D0_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D0_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D0_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D0_CLOUDS_STRATUS_AMOUNT;
		break;

	case 1:
		clouds_cumulus_coverage         = vec2(WEATHER_D1_CLOUDS_CUMULUS_MIN, WEATHER_D1_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D1_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D1_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D1_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D1_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D1_CLOUDS_STRATUS_AMOUNT;
		break;

	case 2:
		clouds_cumulus_coverage         = vec2(WEATHER_D2_CLOUDS_CUMULUS_MIN, WEATHER_D2_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D2_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D2_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D2_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D2_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D2_CLOUDS_STRATUS_AMOUNT;
		break;

	case 3:
		clouds_cumulus_coverage         = vec2(WEATHER_D3_CLOUDS_CUMULUS_MIN, WEATHER_D3_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D3_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D3_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D3_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D3_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D3_CLOUDS_STRATUS_AMOUNT;
		break;

	case 4:
		clouds_cumulus_coverage         = vec2(WEATHER_D4_CLOUDS_CUMULUS_MIN, WEATHER_D4_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D4_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D4_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D4_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D4_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D4_CLOUDS_STRATUS_AMOUNT;
		break;

	case 5:
		clouds_cumulus_coverage         = vec2(WEATHER_D5_CLOUDS_CUMULUS_MIN, WEATHER_D5_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D5_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D5_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D5_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D5_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D5_CLOUDS_STRATUS_AMOUNT;
		break;

	case 6:
		clouds_cumulus_coverage         = vec2(WEATHER_D6_CLOUDS_CUMULUS_MIN, WEATHER_D6_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D6_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D6_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D6_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D6_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D6_CLOUDS_STRATUS_AMOUNT;
		break;

	case 7:
		clouds_cumulus_coverage         = vec2(WEATHER_D7_CLOUDS_CUMULUS_MIN, WEATHER_D7_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D7_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D7_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D7_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D7_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D7_CLOUDS_STRATUS_AMOUNT;
		break;

	case 8:
		clouds_cumulus_coverage         = vec2(WEATHER_D8_CLOUDS_CUMULUS_MIN, WEATHER_D8_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D8_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D8_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D8_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D8_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D8_CLOUDS_STRATUS_AMOUNT;
		break;

	case 9:
		clouds_cumulus_coverage         = vec2(WEATHER_D9_CLOUDS_CUMULUS_MIN, WEATHER_D9_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D9_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D9_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D9_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D9_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D9_CLOUDS_STRATUS_AMOUNT;
		break;

	case 10:
		clouds_cumulus_coverage         = vec2(WEATHER_D10_CLOUDS_CUMULUS_MIN, WEATHER_D10_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D10_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D10_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D10_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D10_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D10_CLOUDS_STRATUS_AMOUNT;
		break;

	case 11:
		clouds_cumulus_coverage         = vec2(WEATHER_D11_CLOUDS_CUMULUS_MIN, WEATHER_D11_CLOUDS_CUMULUS_MAX);
		clouds_altocumulus_coverage     = vec2(WEATHER_D11_CLOUDS_ALTOCUMULUS_MIN, WEATHER_D11_CLOUDS_ALTOCUMULUS_MAX);
		clouds_cirrus_coverage          = WEATHER_D11_CLOUDS_CIRRUS;
		clouds_cumulus_congestus_amount = WEATHER_D11_CLOUDS_CUMULUS_CONGESTUS_AMOUNT;
		clouds_stratus_amount           = WEATHER_D11_CLOUDS_STRATUS_AMOUNT;
		break;
	}
}

void clouds_weather_variation(
	out vec2 clouds_cumulus_coverage,
	out vec2 clouds_altocumulus_coverage,
	out float clouds_cirrus_coverage,
	out float clouds_cumulus_congestus_amount,
	out float clouds_stratus_amount
) {
	// Daily weather variation

#ifdef CLOUDS_DAILY_WEATHER
	vec2 coverage_cu_0, coverage_cu_1;
	vec2 coverage_ac_0, coverage_ac_1;
	float coverage_ci_0, coverage_ci_1;
	float cu_con_0, cu_con_1;
	float stratus_0, stratus_1;

	daily_weather_clouds(worldDay + 0, coverage_cu_0, coverage_ac_0, coverage_ci_0, cu_con_0, stratus_0);
	daily_weather_clouds(worldDay + 1, coverage_cu_1, coverage_ac_1, coverage_ci_1, cu_con_1, stratus_1);

	float mix_factor = weather_mix_factor();

	clouds_cumulus_coverage         = mix(coverage_cu_0, coverage_cu_1, mix_factor);
	clouds_altocumulus_coverage     = mix(coverage_ac_0, coverage_ac_1, mix_factor);
	clouds_cirrus_coverage          = mix(coverage_ci_0, coverage_ci_1, mix_factor);
	clouds_cumulus_congestus_amount = mix(cu_con_0, cu_con_1, mix_factor);
	clouds_stratus_amount           = mix(stratus_0, stratus_1, mix_factor);
#else
	clouds_cumulus_coverage         = vec2(0.4, 0.55);
	clouds_altocumulus_coverage     = vec2(0.3, 0.5);
	clouds_cirrus_coverage          = 0.4;
	clouds_cumulus_congestus_amount = 0.0;
	clouds_stratus_amount           = 0.0;
#endif

	// Weather influence

	clouds_cumulus_coverage = mix(clouds_cumulus_coverage, vec2(0.6, 0.8), wetness) + rainStrength;
	clouds_altocumulus_coverage = mix(clouds_altocumulus_coverage, vec2(0.4, 0.9), wetness * 0.75) + rainStrength;
	clouds_cirrus_coverage = mix(clouds_cirrus_coverage, 0.7, wetness * 0.50);
	clouds_cumulus_congestus_amount *= 1.0 - wetness;
	clouds_stratus_amount = clamp01(clouds_stratus_amount + 0.7 * wetness);

	// User config values

	clouds_cumulus_coverage *= CLOUDS_CUMULUS_COVERAGE;
	clouds_altocumulus_coverage *= CLOUDS_ALTOCUMULUS_COVERAGE;
	clouds_cirrus_coverage *= CLOUDS_CIRRUS_COVERAGE;
}
#endif

// Overworld fog

#ifdef WEATHER_FOG
uniform float desert_sandstorm;

mat2x3 air_fog_rayleigh_coeff() {
	const vec3 rayleigh_normal = from_srgb(vec3(AIR_FOG_RAYLEIGH_R,        AIR_FOG_RAYLEIGH_G,        AIR_FOG_RAYLEIGH_B       )) * AIR_FOG_RAYLEIGH_DENSITY;
	const vec3 rayleigh_rain   = from_srgb(vec3(AIR_FOG_RAYLEIGH_R_RAIN,   AIR_FOG_RAYLEIGH_G_RAIN,   AIR_FOG_RAYLEIGH_B_RAIN  )) * AIR_FOG_RAYLEIGH_DENSITY_RAIN;
	const vec3 rayleigh_arid   = from_srgb(vec3(AIR_FOG_RAYLEIGH_R_ARID,   AIR_FOG_RAYLEIGH_G_ARID,   AIR_FOG_RAYLEIGH_B_ARID  )) * AIR_FOG_RAYLEIGH_DENSITY_ARID;
	const vec3 rayleigh_snowy  = from_srgb(vec3(AIR_FOG_RAYLEIGH_R_SNOWY,  AIR_FOG_RAYLEIGH_G_SNOWY,  AIR_FOG_RAYLEIGH_B_SNOWY )) * AIR_FOG_RAYLEIGH_DENSITY_SNOWY;
	const vec3 rayleigh_taiga  = from_srgb(vec3(AIR_FOG_RAYLEIGH_R_TAIGA,  AIR_FOG_RAYLEIGH_G_TAIGA,  AIR_FOG_RAYLEIGH_B_TAIGA )) * AIR_FOG_RAYLEIGH_DENSITY_TAIGA;
	const vec3 rayleigh_jungle = from_srgb(vec3(AIR_FOG_RAYLEIGH_R_JUNGLE, AIR_FOG_RAYLEIGH_G_JUNGLE, AIR_FOG_RAYLEIGH_B_JUNGLE)) * AIR_FOG_RAYLEIGH_DENSITY_JUNGLE;
	const vec3 rayleigh_swamp  = from_srgb(vec3(AIR_FOG_RAYLEIGH_R_SWAMP,  AIR_FOG_RAYLEIGH_G_SWAMP,  AIR_FOG_RAYLEIGH_B_SWAMP )) * AIR_FOG_RAYLEIGH_DENSITY_SWAMP;

	vec3 rayleigh = rayleigh_normal * biome_temperate
	              + rayleigh_arid   * biome_arid
	              + rayleigh_snowy  * biome_snowy
		          + rayleigh_taiga  * biome_taiga
		          + rayleigh_jungle * biome_jungle
		          + rayleigh_swamp  * biome_swamp;

	// Rain
	rayleigh = mix(rayleigh, rayleigh_rain, rainStrength * biome_may_rain);

	// Daily weather
	float fogginess = daily_weather_blend(daily_weather_fogginess);
	rayleigh *= 1.0 + 2.0 * fogginess;

	return mat2x3(rayleigh, rayleigh);
}

mat2x3 air_fog_mie_coeff() {
	// Increased mie density and scattering strength during late sunset / blue hour
	float blue_hour = linear_step(0.05, 1.0, exp(-190.0 * sqr(sun_dir.y + 0.07283)));

	float mie_coeff = AIR_FOG_MIE_DENSITY_MORNING  * time_sunrise
	                + AIR_FOG_MIE_DENSITY_NOON     * time_noon
	                + AIR_FOG_MIE_DENSITY_EVENING  * time_sunset
	                + AIR_FOG_MIE_DENSITY_MIDNIGHT * time_midnight
	                + AIR_FOG_MIE_DENSITY_BLUE_HOUR * blue_hour;

	mie_coeff = mix(mie_coeff, AIR_FOG_MIE_DENSITY_RAIN, rainStrength * biome_may_rain);
	mie_coeff = mix(mie_coeff, AIR_FOG_MIE_DENSITY_SNOW, rainStrength * biome_may_snow);

	float mie_albedo = mix(0.9, 0.5, rainStrength * biome_may_rain);

	vec3 extinction_coeff = vec3(mie_coeff);
	vec3 scattering_coeff = vec3(mie_coeff * mie_albedo);

#ifdef DESERT_SANDSTORM
	const float desert_sandstorm_density    = 0.2;
	const float desert_sandstorm_scattering = 0.5;
	const vec3  desert_sandstorm_extinction = vec3(0.2, 0.27, 0.45);

	scattering_coeff += desert_sandstorm * (desert_sandstorm_density * desert_sandstorm_scattering);
	extinction_coeff += desert_sandstorm * (desert_sandstorm_density * desert_sandstorm_extinction);
#endif

	return mat2x3(scattering_coeff, extinction_coeff);
}
#endif

// Aurora

#ifdef WEATHER_AURORA
// 0.0 - no aurora
// 1.0 - full aurora
float get_aurora_amount() {
	float night = smoothstep(0.0, 0.2, -sun_dir.y);

#if   AURORA_NORMAL == AURORA_NEVER
	float aurora_normal = 0.0;
#elif AURORA_NORMAL == AURORA_RARELY
	float aurora_normal = float(lowbias32(uint(worldDay)) % 5 == 1);
#elif AURORA_NORMAL == AURORA_ALWAYS
	float aurora_normal = 1.0;
#endif

#if   AURORA_SNOW == AURORA_NEVER
	float aurora_snow = 0.0;
#elif AURORA_SNOW == AURORA_RARELY
	float aurora_snow = float(lowbias32(uint(worldDay)) % 5 == 1);
#elif AURORA_SNOW == AURORA_ALWAYS
	float aurora_snow = 1.0;
#endif

	return night * mix(aurora_normal, aurora_snow, biome_may_snow);
}

// [0] - bottom color
// [1] - top color
mat2x3 get_aurora_colors() {
	const mat2x3[] aurora_colors = mat2x3[](
		mat2x3( // 0
			vec3(AURORA_COLOR_0_BTM_R, AURORA_COLOR_0_BTM_G, AURORA_COLOR_0_BTM_B) * AURORA_COLOR_0_BTM_I,
			vec3(AURORA_COLOR_0_TOP_R, AURORA_COLOR_0_TOP_G, AURORA_COLOR_0_TOP_B) * AURORA_COLOR_0_TOP_I
		)
		, mat2x3( // 1
			vec3(AURORA_COLOR_1_BTM_R, AURORA_COLOR_1_BTM_G, AURORA_COLOR_1_BTM_B) * AURORA_COLOR_1_BTM_I,
			vec3(AURORA_COLOR_1_TOP_R, AURORA_COLOR_1_TOP_G, AURORA_COLOR_1_TOP_B) * AURORA_COLOR_1_TOP_I
		)
		, mat2x3( // 2
			vec3(AURORA_COLOR_2_BTM_R, AURORA_COLOR_2_BTM_G, AURORA_COLOR_2_BTM_B) * AURORA_COLOR_2_BTM_I,
			vec3(AURORA_COLOR_2_TOP_R, AURORA_COLOR_2_TOP_G, AURORA_COLOR_2_TOP_B) * AURORA_COLOR_2_TOP_I
		)
		, mat2x3( // 3
			vec3(AURORA_COLOR_3_BTM_R, AURORA_COLOR_3_BTM_G, AURORA_COLOR_3_BTM_B) * AURORA_COLOR_3_BTM_I,
			vec3(AURORA_COLOR_3_TOP_R, AURORA_COLOR_3_TOP_G, AURORA_COLOR_3_TOP_B) * AURORA_COLOR_3_TOP_I
		)
		, mat2x3( // 4
			vec3(AURORA_COLOR_4_BTM_R, AURORA_COLOR_4_BTM_G, AURORA_COLOR_4_BTM_B) * AURORA_COLOR_4_BTM_I,
			vec3(AURORA_COLOR_4_TOP_R, AURORA_COLOR_4_TOP_G, AURORA_COLOR_4_TOP_B) * AURORA_COLOR_4_TOP_I
		)
		, mat2x3( // 5
			vec3(AURORA_COLOR_5_BTM_R, AURORA_COLOR_5_BTM_G, AURORA_COLOR_5_BTM_B) * AURORA_COLOR_5_BTM_I,
			vec3(AURORA_COLOR_5_TOP_R, AURORA_COLOR_5_TOP_G, AURORA_COLOR_5_TOP_B) * AURORA_COLOR_5_TOP_I
		)
		, mat2x3( // 6
			vec3(AURORA_COLOR_6_BTM_R, AURORA_COLOR_6_BTM_G, AURORA_COLOR_6_BTM_B) * AURORA_COLOR_6_BTM_I,
			vec3(AURORA_COLOR_6_TOP_R, AURORA_COLOR_6_TOP_G, AURORA_COLOR_6_TOP_B) * AURORA_COLOR_6_TOP_I
		)
		, mat2x3( // 7
			vec3(AURORA_COLOR_7_BTM_R, AURORA_COLOR_7_BTM_G, AURORA_COLOR_7_BTM_B) * AURORA_COLOR_7_BTM_I,
			vec3(AURORA_COLOR_7_TOP_R, AURORA_COLOR_7_TOP_G, AURORA_COLOR_7_TOP_B) * AURORA_COLOR_7_TOP_I
		)
		, mat2x3( // 8
			vec3(AURORA_COLOR_8_BTM_R, AURORA_COLOR_8_BTM_G, AURORA_COLOR_8_BTM_B) * AURORA_COLOR_8_BTM_I,
			vec3(AURORA_COLOR_8_TOP_R, AURORA_COLOR_8_TOP_G, AURORA_COLOR_8_TOP_B) * AURORA_COLOR_8_TOP_I
		)
		, mat2x3( // 9
			vec3(AURORA_COLOR_9_BTM_R, AURORA_COLOR_9_BTM_G, AURORA_COLOR_9_BTM_B) * AURORA_COLOR_9_BTM_I,
			vec3(AURORA_COLOR_9_TOP_R, AURORA_COLOR_9_TOP_G, AURORA_COLOR_9_TOP_B) * AURORA_COLOR_9_TOP_I
		)
		, mat2x3( // 10
			vec3(AURORA_COLOR_10_BTM_R, AURORA_COLOR_10_BTM_G, AURORA_COLOR_10_BTM_B) * AURORA_COLOR_10_BTM_I,
			vec3(AURORA_COLOR_10_TOP_R, AURORA_COLOR_10_TOP_G, AURORA_COLOR_10_TOP_B) * AURORA_COLOR_10_TOP_I
		)
		, mat2x3( // 11
			vec3(AURORA_COLOR_11_BTM_R, AURORA_COLOR_11_BTM_G, AURORA_COLOR_11_BTM_B) * AURORA_COLOR_11_BTM_I,
			vec3(AURORA_COLOR_11_TOP_R, AURORA_COLOR_11_TOP_G, AURORA_COLOR_11_TOP_B) * AURORA_COLOR_11_TOP_I
		)
	);

#if AURORA_COLOR == -1
		const uint[] weights = uint[](
			AURORA_COLOR_0_WEIGHT, AURORA_COLOR_1_WEIGHT, AURORA_COLOR_2_WEIGHT, AURORA_COLOR_3_WEIGHT, AURORA_COLOR_4_WEIGHT,
			AURORA_COLOR_5_WEIGHT, AURORA_COLOR_6_WEIGHT, AURORA_COLOR_7_WEIGHT, AURORA_COLOR_8_WEIGHT, AURORA_COLOR_9_WEIGHT,
			AURORA_COLOR_10_WEIGHT, AURORA_COLOR_11_WEIGHT
		);
		const uint total_weight = AURORA_COLOR_0_WEIGHT + AURORA_COLOR_1_WEIGHT + AURORA_COLOR_2_WEIGHT + AURORA_COLOR_3_WEIGHT + AURORA_COLOR_4_WEIGHT +
			AURORA_COLOR_5_WEIGHT + AURORA_COLOR_6_WEIGHT + AURORA_COLOR_7_WEIGHT + AURORA_COLOR_8_WEIGHT + AURORA_COLOR_9_WEIGHT +
			AURORA_COLOR_10_WEIGHT + AURORA_COLOR_11_WEIGHT;
		mat2x3[total_weight] aurora_colors_weighted;
		for(uint i = 0u, index = 0u; i < weights.length(); i++) {
			for(uint j = 0u; j < weights[i]; j++, index++) {
				aurora_colors_weighted[index] = aurora_colors[i];
			}
		}

		uint day_index = uint(worldDay);
			 day_index = lowbias32(day_index) % aurora_colors_weighted.length();
		return aurora_colors_weighted[day_index];
#else
		return aurora_colors[uint(AURORA_COLOR)];
#endif

}
#endif // WEATHER_AURORA

#endif // INCLUDE_MISC_WEATHER
