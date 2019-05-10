
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
/* #define COLOR mix(#7BBBE5, #28a8a4, clamp(pos / GRADIENT_SCALE, 0, 1)) */
#define COLOR mix(#7BBBE5, #1793d1, clamp(pos / GRADIENT_SCALE, 0, 1))
/* 1 to draw outline, 0 to disable */
#define DRAW_OUTLINE 0
/* 1 to draw edge highlight, 0 to disable */
#define DRAW_HIGHLIGHT 0
/* How far to (cubically) vertically anti-alias the border of the graph. A value of
   0.0 means hard borders, greater values mean softer ones.
   Note: smoothing does not have a notable impact on performance, but requires
   `xroot` transparency to be enabled since it relies on alpha blending with
   the background. */
#define SMOOTH_DEGREE 4.0
/* Whether to anti-alias the border of the graph, creating a smoother curve.
   This may have a small impact on performance. Note that this only anti-aliases
   the border, so that the seams between the graph and the outline and/or the
   highlight (if present) will not be aliased.
   Note: This requires `xroot` transparency to be enabled since it
   relies on alpha blending with the background. */
#define ANTI_ALIAS 1
/* outline color */
#define OUTLINE #262626
/* 1 to join the two channels together in the middle, 0 to clamp both down to zero */
#define JOIN_CHANNELS 1
/* 1 to invert (vertically), 0 otherwise */
/* #define INVERT 0 */
#define INVERT 0

/* Gravity step, overrude from `smooth_parameters.glsl` */
/* #request setgravitystep 2.4 */
#request setgravitystep 2.8

/* Smoothing factor, override from `smooth_parameters.glsl` */
#request setsmoothfactor 0.015
