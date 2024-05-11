//
// File: window_gen.cpp
//
// MATLAB Coder version            : 5.2
// C/C++ source code generated on  : 08-Jul-2023 22:41:50
//

// Include Files
#include "window_gen.h"
#include "coder_array.h"
#include <cmath>

// Function Definitions
//
// Arguments    : double type
//                double length
//                coder::array<double, 2U> &window
// Return Type  : void
//
void window_gen(double type, double length, coder::array<double, 2U> &window)
{
  coder::array<double, 2U> a;
  coder::array<double, 2U> varargin_1;
  coder::array<double, 2U> x;
  int i;
  int k;
  int nx;
  x.set_size(1, static_cast<int>(length));
  if (static_cast<int>(length) >= 1) {
    nx = static_cast<int>(length) - 1;
    x[static_cast<int>(length) - 1] = 1.0;
    if (x.size(1) >= 2) {
      x[0] = -1.0;
      if (x.size(1) >= 3) {
        if (static_cast<int>(length) > 2) {
          double delta1;
          delta1 = 1.0 / (static_cast<double>(static_cast<int>(length)) - 1.0);
          for (k = 2; k <= nx; k++) {
            x[k - 1] =
                static_cast<double>(((k << 1) - static_cast<int>(length)) - 1) *
                delta1;
          }
          if ((static_cast<int>(length) & 1) == 1) {
            x[static_cast<int>(length) >> 1] = 0.0;
          }
        } else {
          double delta1;
          delta1 = 2.0 / (static_cast<double>(x.size(1)) - 1.0);
          i = x.size(1);
          for (k = 0; k <= i - 3; k++) {
            x[k + 1] = (static_cast<double>(k) + 1.0) * delta1 + -1.0;
          }
        }
      }
    }
  }
  switch (static_cast<int>(type)) {
  case 0:
    // trapezoidal
    nx = x.size(1);
    a.set_size(1, x.size(1));
    for (k = 0; k < nx; k++) {
      a[k] = std::abs(x[k]);
    }
    a.set_size(1, a.size(1));
    nx = a.size(1) - 1;
    for (i = 0; i <= nx; i++) {
      a[i] = a[i] * 2.0 - 2.0;
    }
    nx = a.size(1);
    varargin_1.set_size(1, a.size(1));
    for (k = 0; k < nx; k++) {
      varargin_1[k] = std::abs(a[k]);
    }
    x.set_size(1, varargin_1.size(1));
    nx = varargin_1.size(1);
    for (k = 0; k < nx; k++) {
      x[k] = std::fmin(varargin_1[k], 1.0);
    }
    window.set_size(1, x.size(1));
    nx = x.size(1);
    for (i = 0; i < nx; i++) {
      window[i] = x[i];
    }
    break;
  default:
    nx = x.size(1);
    a.set_size(1, x.size(1));
    for (k = 0; k < nx; k++) {
      a[k] = std::abs(x[k]);
    }
    a.set_size(1, a.size(1));
    nx = a.size(1) - 1;
    for (i = 0; i <= nx; i++) {
      a[i] = a[i] * 2.0 - 2.0;
    }
    nx = a.size(1);
    varargin_1.set_size(1, a.size(1));
    for (k = 0; k < nx; k++) {
      varargin_1[k] = std::abs(a[k]);
    }
    x.set_size(1, varargin_1.size(1));
    nx = varargin_1.size(1);
    for (k = 0; k < nx; k++) {
      x[k] = std::fmin(varargin_1[k], 1.0);
    }
    window.set_size(1, x.size(1));
    nx = x.size(1);
    for (i = 0; i < nx; i++) {
      window[i] = x[i];
    }
    break;
  }
}

//
// File trailer for window_gen.cpp
//
// [EOF]
//
