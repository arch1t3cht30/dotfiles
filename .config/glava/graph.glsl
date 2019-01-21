
/* Vertical scale, larger values will amplify output */
#define VSCALE 300
/* Rendering direction, either -1 (outwards) or 1 (inwards). */
#define DIRECTION 1

/* Color gradient scale, (optionally) used in `COLOR` macro */
/* #define GRADIENT_SCALE 75 */
#define GRADIENT_SCALE 0
/* Color definition. By default this is a gradient formed by mixing two colors.
   `pos` represents the pixel position relative to the visualizer baseline. */
/* #define COLOR mix(#802A2A, #4F4F92, clamp(pos / GRADIENT_SCALE, 0, 1)) */
/* #define COLOR mix(#7BBBE5, #7BBBE5, clamp(pos / GRADIENT_SCALE, 0, 1)) */
#define COLOR mix(#7BBBE5, #28a8a4, clamp(pos / GRADIENT_SCALE, 0, 1))
/* 1 to draw outline, 0 to disable */
#define DRAW_OUTLINE 0
/* 1 to draw edge highlight, 0 to disable */
#define DRAW_HIGHLIGHT 0
/* outline color */
#define OUTLINE #262626
/* 1 to invert (vertically), 0 otherwise */
/* #define INVERT 0 */
#define INVERT 1

/* Gravity step, overrude from `smooth_parameters.glsl` */
/* #request setgravitystep 2.4 */
#request setgravitystep 2.8

/* Smoothing factor, override from `smooth_parameters.glsl` */
#request setsmoothfactor 0.015
