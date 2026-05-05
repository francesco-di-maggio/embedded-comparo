/*
 * pd_esp32_stubs.c - Stub implementations for Pd functions not available on ESP32
 *
 * This file provides no-op stubs for functions from Pd source files that
 * cannot compile on ESP32 (due to missing system headers like sys/mman.h,
 * dlfcn.h, or unavailable syscalls like mmap, dlopen, fork, etc.)
 *
 * Excluded Pd source files that these stubs replace:
 *   s_inter.c  - GUI interaction, signal handling, sys/mman.h
 *   s_main.c   - Standalone Pd main(), not needed with libpd
 *   s_loader.c - Dynamic library loading (dlopen)
 *   s_net.c    - Socket networking for GUI communication
 *   x_net.c    - Pd [netsend]/[netreceive] objects
 *
 * Based on the ESPD reference implementation's pdmain.c stubs.
 */

#include "pd_build_defines.h"
#include "pure_data/src/m_pd.h"
#include "pure_data/src/s_stuff.h"
#include "pure_data/src/g_canvas.h"
#include "pure_data/src/g_undo.h"

#include <string.h>
#include <sys/time.h>

/* ===================== s_inter.c stubs ===================== */

void sys_vgui(const char *format, ...) {}
void sys_gui(const char *s) {}

int sys_havegui(void) { return 0; }
int sys_havetkproc(void) { return 0; }
int sys_pollgui(void) { return 0; }

void sys_lock(void) {}
void sys_unlock(void) {}
void pd_globallock(void) {}
void pd_globalunlock(void) {}

void sys_queuegui(void *client, t_glist *glist, t_guicallbackfn f) {}
void sys_unqueuegui(void *client) {}

int sys_hostfontsize(int fontsize, int zoom) { return 1; }
int sys_zoomfontwidth(int fontsize, int zoom, int worstcase) { return 1; }
int sys_zoomfontheight(int fontsize, int zoom, int worstcase) { return 1; }
char sys_fontweight[10] = "normal";
char sys_font[10] = "courier";
int sys_defaultfont = 10;

void sys_init_fdpoll(void) {}
void sys_addpollfn(int fd, t_fdpollfn fn, void *ptr) {}
void sys_removepollfn(int fd) {}
void sys_closesocket(int fd) {}

void s_inter_newpdinstance(void) {}
void s_inter_freepdinstance(void) {}

void sys_bail(int n) {}

/* GUI dialog stubs (from s_inter.c) */
void glob_initfromgui(void *dummy, t_symbol *s, int argc, t_atom *argv) {}
void glob_quit(void *dummy, t_floatarg status) {}
void glob_exit(void *dummy, t_floatarg status) {}
void glob_start_preference_dialog(void) {}
void glob_start_path_dialog(void) {}
void glob_path_dialog(void *dummy, t_symbol *s, int argc, t_atom *argv) {}
void glob_addtopath(void *dummy, t_symbol *s, int argc, t_atom *argv) {}
void glob_start_startup_dialog(void) {}
void glob_startup_dialog(void *dummy, t_symbol *s, int argc, t_atom *argv) {}
void glob_ping(void *dummy) {}
void glob_watchdog(void *dummy) {}
void glob_vis(void *dummy, t_symbol *s, int argc, t_atom *argv) {}

t_symbol *sys_decodedialog(t_symbol *s) { return s; }
void messqueue_dispatch(void) {}

/* get "real time" in seconds */
double sys_getrealtime(void)
{
    static struct timeval then;
    struct timeval now;
    gettimeofday(&now, 0);
    if (then.tv_sec == 0 && then.tv_usec == 0) then = now;
    return ((now.tv_sec - then.tv_sec) +
        (1./1000000.) * (now.tv_usec - then.tv_usec));
}

/* ===================== s_main.c stubs ===================== */

/* libpd has its own init path; these are never called */
void sys_findprogdir(const char *progname) {}
int sys_argparse(int argc, char **argv) { return 0; }
/* sys_zoom_open is defined in m_glob.c */
int sys_hipriority = 0;
int sys_externalschedlib = 0;
int sys_batch = 0;

/* ===================== s_loader.c stubs ===================== */

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
/* class_set_extern_dir is defined in m_class.c */

/* ===================== s_net.c stubs ===================== */

/* No socket communication needed for headless ESP32 */

/* ===================== Global variables from excluded files ===================== */

t_symbol *sys_libdir;
int sys_verbose = 0;
int sys_noloadbang = 0;
int sys_noautopatch = 0;
int sys_debuglevel = 0;
int sys_nmidiin = 0;
int sys_nmidiout = 0;

int sys_nearestfontsize(int fontsize) { return fontsize; }
int sys_getblksize(void) { return DEFDACBLKSIZE; }

/* Audio system stubs (from m_sched.c / s_audio.c) */
void sys_reopen_audio(void) {}
void sys_close_audio(void) {}
/* audio_isopen and audio_shouldkeepopen are in s_audio.c */
void sys_log_error(int type) { (void)type; }
int sched_get_using_audio(void) { return 2; /* SCHED_AUDIO_CALLBACK */ }
void sched_set_using_audio(int flag) { (void)flag; }
void glob_audiostatus(void *dummy) { (void)dummy; }
void glob_fastforward(void *dummy, t_symbol *s, int argc, t_atom *argv) {
    (void)dummy; (void)s; (void)argc; (void)argv;
}

/* ===================== x_net.c stubs ===================== */

/* Provide empty setup so m_conf.c can call it */
void x_net_setup(void) {}

/* ===================== d_fft.c stubs (FFT excluded) ===================== */

void d_fft_setup(void) {}

/* ===================== Missing POSIX stubs ===================== */

/* ESP32 newlib doesn't provide full glob() or geteuid() */

#include <glob.h>
#ifndef GLOB_NOMATCH
#define GLOB_NOMATCH 3
#endif

int glob(const char *pattern, int flags,
         int (*errfunc)(const char *, int), glob_t *pglob) {
    (void)pattern; (void)flags; (void)errfunc;
    if (pglob) {
        pglob->gl_pathc = 0;
        pglob->gl_pathv = NULL;
    }
    return GLOB_NOMATCH;
}

void globfree(glob_t *pglob) {
    (void)pglob;
}

/* geteuid not available on FreeRTOS */
unsigned int geteuid(void) { return 0; }
