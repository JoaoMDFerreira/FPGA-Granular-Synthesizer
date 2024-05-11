//
// File: _coder_window_gen_api.h
//
// MATLAB Coder version            : 5.2
// C/C++ source code generated on  : 08-Jul-2023 22:41:50
//

#ifndef _CODER_WINDOW_GEN_API_H
#define _CODER_WINDOW_GEN_API_H

// Include Files
#include "coder_array_mex.h"
#include "emlrt.h"
#include "tmwtypes.h"
#include <algorithm>
#include <cstring>

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void window_gen(real_T type, real_T length, coder::array<real_T, 2U> *window);

void window_gen_api(const mxArray *const prhs[2], const mxArray **plhs);

void window_gen_atexit();

void window_gen_initialize();

void window_gen_terminate();

void window_gen_xil_shutdown();

void window_gen_xil_terminate();

#endif
//
// File trailer for _coder_window_gen_api.h
//
// [EOF]
//
