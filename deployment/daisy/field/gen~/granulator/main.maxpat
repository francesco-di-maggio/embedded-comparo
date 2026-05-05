{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 4,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 34.0, 91.0, 541.0, 542.0 ],
        "subpatcher_template": "oopsy_field",
        "boxes": [
            {
                "box": {
                    "id": "obj-16",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 286.0, 489.0, 218.0, 33.0 ],
                    "text": "This is how long your gen~ data object needs to be to fit the wav data into it."
                }
            },
            {
                "box": {
                    "id": "obj-12",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 480.0, 280.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-14",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 286.0, 453.0, 110.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 286.0, 424.0, 53.0, 22.0 ],
                    "text": "* 48000."
                }
            },
            {
                "box": {
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 349.0, 368.0, 47.0, 22.0 ],
                    "text": "* 0.001"
                }
            },
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 10,
                    "outlettype": [ "float", "list", "float", "float", "float", "float", "float", "", "int", "" ],
                    "patching_rect": [ 286.0, 335.0, 113.5, 22.0 ],
                    "text": "info~ sample"
                }
            },
            {
                "box": {
                    "id": "obj-17",
                    "linecount": 3,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 287.0, 215.0, 217.0, 47.0 ],
                    "text": "\"@sample drumloop\" automatically loads the content of [buffer~ drumloop] into the gen~ object's [data sample]"
                }
            },
            {
                "box": {
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "float", "bang" ],
                    "patching_rect": [ 286.0, 281.0, 166.0, 22.0 ],
                    "text": "buffer~ sample drumloop.wav"
                }
            },
            {
                "box": {
                    "attr": "knob8_gain",
                    "id": "obj-8",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 24.0, 258.0, 201.0, 22.0 ],
                    "text_width": 150.0
                }
            },
            {
                "box": {
                    "attr": "knob7_stereo_spread",
                    "id": "obj-6",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 24.0, 225.0, 201.0, 22.0 ],
                    "text_width": 150.0
                }
            },
            {
                "box": {
                    "attr": "knob6_spray",
                    "id": "obj-5",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 24.0, 192.0, 201.0, 22.0 ],
                    "text_width": 150.0
                }
            },
            {
                "box": {
                    "attr": "knob1_density",
                    "id": "obj-97",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 24.0, 27.0, 201.0, 22.0 ],
                    "text_width": 150.0
                }
            },
            {
                "box": {
                    "attr": "knob2_grain_size",
                    "id": "obj-37",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 24.0, 60.0, 201.0, 22.0 ],
                    "text_width": 150.0
                }
            },
            {
                "box": {
                    "attr": "knob3_pitch",
                    "id": "obj-38",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 24.0, 93.0, 201.0, 22.0 ],
                    "text_width": 150.0
                }
            },
            {
                "box": {
                    "attr": "knob4_position",
                    "id": "obj-10",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 24.0, 126.0, 201.0, 22.0 ],
                    "text_width": 150.0
                }
            },
            {
                "box": {
                    "attr": "knob5_spread",
                    "id": "obj-32",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 24.0, 159.0, 201.0, 22.0 ],
                    "text_width": 150.0
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 24.0, 467.0, 49.25, 49.25 ]
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "lastchannelcount": 0,
                    "maxclass": "live.gain~",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "orientation": 1,
                    "outlettype": [ "signal", "signal", "", "float", "list" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 24.0, 395.0, 140.0, 47.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "live.gain~",
                            "parameter_mmax": 6.0,
                            "parameter_mmin": -70.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "live.gain~",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    },
                    "varname": "live.gain~"
                }
            },
            {
                "box": {
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "signal" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 4,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "dsp.gen",
                        "rect": [ 34.0, 91.0, 1372.0, 807.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-6",
                                    "linecount": 4,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 741.0, 26.0, 379.0, 60.0 ],
                                    "text": "Adapted from: \nMax/MSP Tutorial | A granular synthesiser built with [codebox] in gen~\n\nhttps://www.youtube.com/watch?v=VU2TQmxte9A"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-34",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 847.0, 239.0, 108.0, 22.0 ],
                                    "text": "oopsy.ctrl.smooth3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-33",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 729.1428571428571, 213.0, 108.0, 22.0 ],
                                    "text": "oopsy.ctrl.smooth3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-32",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 611.2857142857143, 186.28571428571433, 108.0, 22.0 ],
                                    "text": "oopsy.ctrl.smooth3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-31",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 493.42857142857144, 161.0, 108.0, 22.0 ],
                                    "text": "oopsy.ctrl.smooth3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-30",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 376.0, 137.0, 108.0, 22.0 ],
                                    "text": "oopsy.ctrl.smooth3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-29",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 258.0, 112.0, 108.0, 22.0 ],
                                    "text": "oopsy.ctrl.smooth3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-26",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 140.0, 83.0, 108.0, 22.0 ],
                                    "text": "oopsy.ctrl.smooth3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-25",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 22.0, 54.0, 108.0, 22.0 ],
                                    "text": "oopsy.ctrl.smooth3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 847.0, 213.0, 273.0, 22.0 ],
                                    "text": "param knob8_gain @default 0.7 @min 0 @max 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 729.1428571428571, 186.0, 327.0, 22.0 ],
                                    "text": "param knob7_stereo_spread @default 0.7 @min 0 @max 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-22",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 611.2857142857143, 161.28571428571433, 286.0, 22.0 ],
                                    "text": "param knob6_spray @default 0.08 @min 0 @max 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 493.42857142857144, 136.0, 293.0, 22.0 ],
                                    "text": "param knob5_spread @default 0.15 @min 0 @max 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-20",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 376.0, 112.0, 291.0, 22.0 ],
                                    "text": "param knob4_position @default 0.5 @min 0 @max 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-19",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 258.0, 84.0, 283.0, 22.0 ],
                                    "text": "param knob3_pitch @default 0 @min -24 @max 48"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-18",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 140.0, 54.0, 321.0, 22.0 ],
                                    "text": "param knob2_grain_size @default 120 @min 5 @max 500"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 928.0, 762.0, 127.0, 22.0 ],
                                    "text": "data sample 153400 2"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 928.0, 716.0, 63.0, 22.0 ],
                                    "text": "data pr 32"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 928.0, 688.0, 61.0, 22.0 ],
                                    "text": "data pl 32"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 928.0, 661.0, 67.0, 22.0 ],
                                    "text": "data inc 32"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 928.0, 634.0, 71.0, 22.0 ],
                                    "text": "data pos 32"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 928.0, 607.0, 64.0, 22.0 ],
                                    "text": "data sz 32"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 927.0, 580.0, 65.0, 22.0 ],
                                    "text": "data ph 32"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-4",
                                    "linecount": 73,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1151.0, 26.0, 447.0, 985.0 ],
                                    "text": "hann(count, size) {\n    phz = count / size;\n    phz *= TWOPI;\n    \n    return 0.5 - 0.5 * cos(phz);   \n}\n\npan(sprd, trig) {\n    n = latch(noise(), trig);\n    n = 0.5 + (n * 0.5 * sprd);\n    n = clamp(n, 0, 1);\n    \n    l = sqrt(1 - n);\n    r = sqrt(n);\n    \n    return l, r;\n}\n\nmake_grain(voice, count, buf, size, position, pitch, spread, spray, stereo_spread) { \n\n    trig = delta(count == voice) == 1;\n    count = min(counter(1, trig), latch(size, trig));\n\n    pos = latch(position + (noise() * spray), trig);\n    pos *= dim(buf);\n    \n    sprd = noise() * spread;\n    sprd = pow(2, sprd);\n    \n    i = pos + (count * latch(pitch * sprd, trig));\n\n    amp = hann(count, latch(size, trig));\n    smp = peek(buf, i, boundmode=\"wrap\", interp=\"cubic\");\n\n    grain = amp * smp;   \n    \n    pan_left, pan_right = pan(stereo_spread, trig);\n    \n    grain_left = grain * pan_left;\n    grain_right = grain * pan_right;\n    \n    return grain_left, grain_right;\n}\n\nBuffer smpl(\"sample\");\n\nParam density(20, min = 0, max = 100);\nParam grain_size(100, min = 2, max = 500);\nParam pitch(0, min = -100, max = 100);\nParam position(0, min = 0, max = 1);\nParam spread(0, min = 0, max = 1);\nParam spray(0, min = 0, max = 1);\nParam stereo_spread(1, min = 0, max = 1);\n\nvoices = 8;\nsize = mstosamps(grain_size);\n\np = delta(phasor(density)) < 0;\npch = pow(2, pitch / 12);\n\nc = counter(p, in1, voices);\n\nout_left = 0;\nout_right = 0;\n\nfor (i = 0; i < voices; i += 1) {\n    l, r = make_grain(i, c, smpl, size, position, pch, spread, spray, stereo_spread);\n    out_left += l;\n    out_right += r;\n}\n\nout1 = out_left;\nout2 = out_right;"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 847.0, 762.0, 35.0, 22.0 ],
                                    "text": "out 2"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 22.0, 762.0, 35.0, 22.0 ],
                                    "text": "out 1"
                                }
                            },
                            {
                                "box": {
                                    "code": "// ============================================================\n// GRANULATOR CLOUD (8–32 voices) — gen~ CodeBox\n//\n// Per-voice state (create as gen~ data objects, size = 32):\n//   data ph  32   // phase: current sample index within grain\n//   data sz  32   // size: grain length in samples\n//   data pos 32   // start: source buffer start index (samples)\n//   data inc 32   // increment: playback speed ratio (incl. spread)\n//   data pl  32   // pan left  (equal-power)\n//   data pr  32   // pan right (equal-power)\n//\n// Source audio (SD / data buffer):\n//   data sample <frames> <channels>\n//\n// Inlets (wire from param objects / UI):\n//   in1 density       grains/sec\n//   in2 grain_ms      ms\n//   in3 pitch_st      semitones\n//   in4 position      0..1\n//   in5 spread        0..1   (pitch randomness)\n//   in6 spray         0..1   (position randomness)\n//   in7 stereoSpread  0..1   (pan randomness)\n//   in8 gain          0..1\n// ============================================================\n\n// ============================================================\n// Helpers (must be defined before any statements)\n// ============================================================\n\nwrap01(x) {\n    // Wrap any float into [0..1)\n    return x - floor(x);\n}\n\nhann(ph, sz) {\n    // Hann window across grain phase [0..sz)\n    x = ph / max(1, sz);\n    return 0.5 - 0.5 * cos(TWOPI * x);\n}\n\nequalpan(n) {\n    // Equal-power pan, n in [0..1]\n    n = clamp(n, 0, 1);\n    return sqrt(1 - n), sqrt(n);\n}\n\n// ============================================================\n// Voice scheduler\n// ============================================================\n\nHistory v(0);          // round-robin voice index\r\n\nvoices = 8;            // <= 32 (must match data array sizes)\n\n// ============================================================\n// Read & sanitize controls\n// ============================================================\n\ndensity      = max(in1, 0.001);     // avoid divide-by-zero / stuck phasor\ngrain_ms     = clamp(in2, 1, 500);  // keep grains bounded + safe\npitch_st     = in3;\nposition     = clamp(in4, 0, 1);\nspread       = clamp(in5, 0, 1);\nspray        = clamp(in6, 0, 1);\nstereoSpread = clamp(in7, 0, 1);\ngain         = clamp(in8, 0, 1);\r\ngain         = (gain < 0.005) ? 0 : gain;   // deadband to kill knob/ADC jitter near 0\n\n// ============================================================\n// Derived values\n// ============================================================\n\nsz_new = clamp(mstosamps(grain_ms), 1, samplerate);  // grain size in samples\ninc_base = pow(2, pitch_st / 12);                    // semitone -> ratio\nbuflen = max(1, dim(sample));                        // frames in source buffer (guard against 0)\n\n// ============================================================\n// Trigger: one-sample tick on phasor wrap\n// ============================================================\n\np = (delta(phasor(density)) < 0);\n\n// ============================================================\n// Allocate one grain on trigger (write voice state)\n// ============================================================\n\nif (p) {\n\n    // Choose next voice (0..voices-1)\n    v = (v + 1) % voices;\n\n    // Position with spray (wrap into 0..1 then scale to buffer frames)\n    pos_new = wrap01(position + noise() * spray) * buflen;\n\n    // Pitch spread: ratio * 2^(rnd * spread), rnd in [-1..1]\n    rnd     = noise() * 2 - 1;\n    inc_new = inc_base * pow(2, rnd * spread);\n\n    // Pan around center with stereoSpread depth\n    pan_n = 0.5 + noise() * 0.5 * stereoSpread;\n    pl_new, pr_new = equalpan(pan_n);\n\n    // Commit state for this voice\n    poke(ph,  0,       v);\n    poke(sz,  sz_new,  v);\n    poke(pos, pos_new, v);\n    poke(inc, inc_new, v);\n    poke(pl,  pl_new,  v);\n    poke(pr,  pr_new,  v);\n}\n\n// ============================================================\n// Render: sum all active voices\n// ============================================================\n\noutL = 0;\noutR = 0;\n\nfor (i = 0; i < voices; i += 1) {\n\n    ph_i = peek(ph, i);\n    sz_i = peek(sz, i);\n\n    // Only render if this voice is currently active\n    if (ph_i < sz_i) {\n\n        pos_i = peek(pos, i);\n        inc_i = peek(inc, i);\n        pl_i  = peek(pl,  i);\n        pr_i  = peek(pr,  i);\n\n        // Read source sample at (pos + phase * increment)\n        idx = pos_i + ph_i * inc_i;\n        s   = peek(sample, idx, boundmode=\"wrap\", interp=\"cubic\");\n\n        // Window + pan\n        a = hann(ph_i, sz_i);\n        g = a * s;\n\n        outL += g * pl_i;\n        outR += g * pr_i;\n\n        // Advance this grain by 1 sample\n        poke(ph, ph_i + 1, i);\n    }\n}\n\n// ============================================================\n// Output\n// ============================================================\n\r\n// Normalize to keep level roughly consistent as voice count increases\r\n// norm = 1 / sqrt(max(1, voices));\r\n\n// out1 = outL * gain * norm;\n// out2 = outR * gain * norm;\r\n\r\nout1 = outL * gain;\r\nout2 = outR * gain;",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-187",
                                    "maxclass": "codebox",
                                    "numinlets": 8,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 22.0, 290.0, 844.0, 448.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-193",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 22.0, 26.0, 321.0, 22.0 ],
                                    "text": "param knob1_density @default 20 @min 0.001 @max 100"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 0 ],
                                    "midpoints": [ 149.5, 78.0, 149.5, 78.0 ],
                                    "source": [ "obj-18", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "midpoints": [ 856.5, 741.0, 856.5, 741.0 ],
                                    "source": [ "obj-187", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-7", 0 ],
                                    "midpoints": [ 31.5, 741.0, 31.5, 741.0 ],
                                    "source": [ "obj-187", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-29", 0 ],
                                    "midpoints": [ 267.5, 108.0, 267.5, 108.0 ],
                                    "source": [ "obj-19", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-25", 0 ],
                                    "midpoints": [ 31.5, 51.0, 31.5, 51.0 ],
                                    "source": [ "obj-193", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-30", 0 ],
                                    "midpoints": [ 385.5, 135.0, 385.5, 135.0 ],
                                    "source": [ "obj-20", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-33", 0 ],
                                    "midpoints": [ 738.6428571428571, 210.0, 738.6428571428571, 210.0 ],
                                    "source": [ "obj-21", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-32", 0 ],
                                    "midpoints": [ 620.7857142857143, 186.0, 620.7857142857143, 186.0 ],
                                    "source": [ "obj-22", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-31", 0 ],
                                    "midpoints": [ 502.92857142857144, 159.0, 502.92857142857144, 159.0 ],
                                    "source": [ "obj-23", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-34", 0 ],
                                    "midpoints": [ 856.5, 237.0, 856.5, 237.0 ],
                                    "source": [ "obj-24", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-187", 0 ],
                                    "midpoints": [ 31.5, 78.0, 31.5, 78.0 ],
                                    "source": [ "obj-25", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-187", 1 ],
                                    "midpoints": [ 149.5, 108.0, 149.35714285714286, 108.0 ],
                                    "source": [ "obj-26", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-187", 2 ],
                                    "midpoints": [ 267.5, 135.0, 267.2142857142857, 135.0 ],
                                    "source": [ "obj-29", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-187", 3 ],
                                    "midpoints": [ 385.5, 162.0, 385.07142857142856, 162.0 ],
                                    "source": [ "obj-30", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-187", 4 ],
                                    "midpoints": [ 502.92857142857144, 186.0, 502.92857142857144, 186.0 ],
                                    "source": [ "obj-31", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-187", 5 ],
                                    "midpoints": [ 620.7857142857143, 210.0, 620.7857142857143, 210.0 ],
                                    "source": [ "obj-32", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-187", 6 ],
                                    "midpoints": [ 738.6428571428571, 237.0, 738.6428571428571, 237.0 ],
                                    "source": [ "obj-33", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-187", 7 ],
                                    "midpoints": [ 856.5, 264.0, 856.5, 264.0 ],
                                    "source": [ "obj-34", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 24.0, 335.0, 159.0, 22.0 ],
                    "text": "gen~ @title granular.gendsp",
                    "varname": "granular"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-15", 0 ],
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 358.5, 359.0, 358.5, 359.0 ],
                    "source": [ "obj-1", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 33.5, 150.0, 33.5, 150.0 ],
                    "source": [ "obj-10", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-13", 1 ],
                    "midpoints": [ 63.75, 444.0, 63.75, 444.0 ],
                    "source": [ "obj-11", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-13", 0 ],
                    "midpoints": [ 33.5, 444.0, 33.5, 444.0 ],
                    "source": [ "obj-11", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 489.5, 320.0, 295.5, 320.0 ],
                    "source": [ "obj-12", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-14", 0 ],
                    "source": [ "obj-15", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 442.5, 320.0, 295.5, 320.0 ],
                    "source": [ "obj-18", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-11", 1 ],
                    "midpoints": [ 173.5, 381.0, 154.5, 381.0 ],
                    "source": [ "obj-3", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-11", 0 ],
                    "midpoints": [ 33.5, 360.0, 33.5, 360.0 ],
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 33.5, 183.0, 33.5, 183.0 ],
                    "source": [ "obj-32", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 33.5, 84.0, 33.5, 84.0 ],
                    "source": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 33.5, 117.0, 33.5, 117.0 ],
                    "source": [ "obj-38", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 1 ],
                    "midpoints": [ 358.5, 410.0, 329.5, 410.0 ],
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 33.5, 216.0, 33.5, 216.0 ],
                    "source": [ "obj-5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 33.5, 249.0, 33.5, 249.0 ],
                    "source": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 33.5, 306.0, 33.5, 306.0 ],
                    "source": [ "obj-8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 33.5, 51.0, 33.5, 51.0 ],
                    "source": [ "obj-97", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-11": [ "live.gain~", "live.gain~", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0
    }
}