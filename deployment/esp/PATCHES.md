# ESPdLib patches

This project's `~/Documents/Arduino/libraries/ESPdLib` differs from `algomusic/ESPdLib` upstream by **one patch** that enables `.pd` abstraction loading.

## Drop-in install

The patched files sit alongside this doc — copy them in to skip the manual diff:

- [`pd_s_loader.c`](pd_s_loader.c) → copy into `~/Documents/Arduino/libraries/ESPdLib/src/pure_data/` (new file).
- [`pd_esp32_stubs.c`](pd_esp32_stubs.c) → replace `~/Documents/Arduino/libraries/ESPdLib/src/pd_esp32_stubs.c` (full file with patch baked in).

Then rebuild any sketch. The diff below documents what changed if you want to apply it by hand or audit the change.

## Files

- `src/pure_data/pd_s_loader.c` — new file (16 lines).
- `src/pd_esp32_stubs.c`, line 101 — `sys_load_lib` stub replaced by `sys_deken_specifier` stub.

### `src/pure_data/pd_s_loader.c`

```c
/*
 * pd_s_loader.c — abstraction loader for ESPdLib
 *
 * Includes s_loader.inc so that .pd abstractions are found 
 * and instantiated at runtime.
 *
 * Binary externals (.so/.dll) are never attempted on ESP32 because
 * HAVE_LIBDL is not defined and _WIN32 is not defined, so those
 * code-paths compile away. The "#warning No dynamic loading
 * mechanism" from s_loader.inc is expected and harmless — suppress
 * it to keep the build output clean.
 */

#pragma GCC diagnostic ignored "-Wcpp"
#include "../pd_build_defines.h"
#include "src/s_loader.inc"
```

### `src/pd_esp32_stubs.c`, line 101

Before:

```c
int sys_load_lib(t_canvas *canvas, const char *classname) { return 0; }
```

After:

```c
/* sys_load_lib is now provided by pure_data/pd_s_loader.c (includes s_loader.inc).
   Only sys_deken_specifier needs a stub — it is defined in s_inter.inc which is
   excluded from this build. Returning NULL causes sys_get_dllextensions() to
   produce an empty list, so binary external loading is silently skipped while
   .pd abstraction loading (the only thing we need) works normally. */
#include <stddef.h>
const char *sys_deken_specifier(char *buf, size_t bufsize,
                                 int include_floatsize, int cpu)
{
    (void)buf; (void)bufsize; (void)include_floatsize; (void)cpu;
    return NULL;
}
```

## Mechanism

The upstream `sys_load_lib` stub returns 0 — libpd's "could not load" path. Compiling in upstream Pd's `s_loader.inc` provides the real loader. `s_inter.inc` is excluded from the ESPdLib build (it pulls TCL/networking dependencies); the one symbol from it that `s_loader.inc` references — `sys_deken_specifier` — is stubbed to return `NULL`. NULL skips binary-external loading silently; `.pd` abstraction loading works normally.

## Known limitations of this libpd build (from testing)

- Default 8 KB Arduino loopTask stack overflows during `openPatch()` once abstractions are involved (libpd's `binbuf_evalfile` recurses with ~1 KB locals per level). Sketches must call `SET_LOOP_TASK_STACK_SIZE(32 * 1024)`.

- Abstraction count ceiling: 4 instances load with 32 KB stack; 8 instances crash during `openPatch()` even at 64 KB stack (heap/object-pool).
