//Shooting stars based off of https://www.shadertoy.com/view/ttVXDy

// Customizable settings
  
  #define SHOOTING_STARS // [on off]
  #define SHOOTING_STARS_ZOOM 0.35 // [0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.60 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.70 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00]
  #define SHOOTING_STARS_SPEED 2.0 // [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0]
  #define SHOOTING_STARS_DENSITY 0.015 // [0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.010 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.020 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.030]
  #define SHOOTING_STARS_COUNT 10 // [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20]
  #define SHOOTING_STARS_LINE_THICKNESS 0.0025 // [0.0005 0.0010 0.0015 0.0020 0.0025 0.0030 0.0035 0.0040 0.0045 0.0050 0.0055 0.0060 0.0065 0.0070 0.0075 0.0080 0.0085 0.0090 0.0095 0.0100]
  #define SHOOTING_STARS_TRAIL_LENGTH 0.200 // [0.025 0.050 0.075 0.100 0.125 0.150 0.175 0.200 0.225 0.250 0.275 0.300 0.325 0.350 0.375 0.400 0.425 0.450 0.475 0.500]
  #define SHOOTING_STARS_TRAIL_FADE 0.15 // [0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30]
  

#define S(a,b,t) smoothstep(a,b,t)

float N21(vec2 p) {
    p = fract(p*vec2(233.34, 851.73));
    p += dot(p, p+23.45);
    return fract(p.x * p.y);
}

float DistLine(vec2 p, vec2 a, vec2 b) {
    vec2 pa = p-a;
    vec2 ba = b-a;
    float t = clamp(dot(pa, ba)/ dot(ba, ba), 0.0, 1.0);
    return length(pa - ba*t);
}

float DrawLine(vec2 p, vec2 a, vec2 b) {
    float d = DistLine(p, a, b);
    float m = S(SHOOTING_STARS_LINE_THICKNESS, 0.00001, d);
    float d2 = length(a-b);
    m *= S(1.0, 0.5, d2) + S(0.04, 0.03, abs(d2-0.75));
    return m;
}

float ShootingStar(vec2 uv, vec2 startPos, vec2 direction) {    
    vec2 gv = fract(uv)-0.5;
    vec2 id = floor(uv);
    
    float h = N21(id);
    
    if (h > SHOOTING_STARS_DENSITY) return 0.0;
    
    float line = DrawLine(gv, startPos, startPos + direction * SHOOTING_STARS_TRAIL_LENGTH);
    float trail = S(SHOOTING_STARS_TRAIL_FADE, 0.0, dot(gv - startPos, normalize(direction)));
	
    return line * trail;
}

vec3 DrawShootingStars(vec3 color, vec3 worldPosition) {
    #ifndef SHOOTING_STARS
    return color;
    #endif

    float visibility = 0.0;

    #ifdef WORLD_OVERWORLD
    float nightFactor = smoothstep(0.0, 0.1, -sun_dir.y);
    visibility = nightFactor * (1.0 - rainStrength);
    #endif

    if (visibility <= 0.0) return color;

    vec2 uv = worldPosition.xz / worldPosition.y;
    uv *= SHOOTING_STARS_ZOOM;
    
    float t = frameTimeCounter * SHOOTING_STARS_SPEED;

    vec2 startPositions[20] = vec2[](
        vec2(-0.4, 0.3),
        vec2(0.2, 0.4),
        vec2(-0.1, -0.3),
        vec2(0.3, -0.2),
        vec2(-0.3, 0.1),
        vec2(0.5, 0.2),
        vec2(-0.5, -0.1),
        vec2(0.1, 0.5),
        vec2(-0.2, -0.4),
        vec2(0.4, -0.3),
        vec2(0.6, 0.1),
        vec2(-0.6, 0.4),
        vec2(0.3, -0.5),
        vec2(-0.4, -0.2),
        vec2(0.2, 0.6),
        vec2(-0.1, -0.6),
        vec2(0.5, -0.4),
        vec2(-0.3, 0.5),
        vec2(0.7, 0.3),
        vec2(-0.7, -0.3)
    );

    vec2 directions[20] = vec2[](
        normalize(vec2(0.7, 0.7)),
        normalize(vec2(0.7, -0.7)),
        normalize(vec2(-0.7, 0.0)),
        normalize(vec2(0.7, 0.0)),
        normalize(vec2(0.5, 0.8)),
        normalize(vec2(-0.6, 0.8)),
        normalize(vec2(0.9, -0.4)),
        normalize(vec2(-0.8, -0.6)),
        normalize(vec2(0.3, 0.95)),
        normalize(vec2(-0.2, -0.98)),
        normalize(vec2(0.8, 0.6)),
        normalize(vec2(-0.9, 0.4)),
        normalize(vec2(0.5, -0.9)),
        normalize(vec2(-0.4, 0.9)),
        normalize(vec2(0.2, 0.98)),
        normalize(vec2(-0.3, -0.95)),
        normalize(vec2(0.95, -0.3)),
        normalize(vec2(-0.7, 0.7)),
        normalize(vec2(0.6, -0.8)),
        normalize(vec2(-0.5, -0.85))
    );

    float stars = 0.0;
    for (int i = 0; i < 20; i++) {
        vec2 offsetUV = uv + t * directions[i] * (0.8 + 0.4 * float(i) / 20.0);
        stars += ShootingStar(offsetUV, startPositions[i], directions[i]);
    }

    vec3 shootingStars = vec3(clamp(stars, 0.0, 1.0));
    return color + shootingStars * visibility;
}
