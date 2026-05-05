/*
 * pd_s_loader.c — abstraction loader for ESPdLib
 *
 * Includes s_loader.inc so that .pd abstractions are found 
 * and instantiated at runtime.
 *
 * Binary externals (.so/.dll) are never attempted on ESP32 because HAVE_LIBDL
 * is not defined and _WIN32 is not defined, so those code-paths compile away.
 * The "#warning No dynamic loading mechanism" from s_loader.inc is expected
 * and harmless — suppress it to keep the build output clean.
 */

#pragma GCC diagnostic ignored "-Wcpp"
#include "../pd_build_defines.h"
#include "src/s_loader.inc"
