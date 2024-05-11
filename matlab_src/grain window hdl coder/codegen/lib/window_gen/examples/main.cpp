//
// File: main.cpp
//
// MATLAB Coder version            : 5.2
// C/C++ source code generated on  : 08-Jul-2023 22:41:50
//

/*************************************************************************/
/* This automatically generated example C++ main file shows how to call  */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/

// Include Files
#include "main.h"
#include "window_gen.h"
#include "window_gen_terminate.h"
#include "coder_array.h"

// Function Declarations
static double argInit_real_T();

static void main_window_gen();

// Function Definitions
//
// Arguments    : void
// Return Type  : double
//
static double argInit_real_T()
{
  return 0.0;
}

//
// Arguments    : void
// Return Type  : void
//
static void main_window_gen()
{
  coder::array<double, 2U> window;
  double type_tmp;
  // Initialize function 'window_gen' input arguments.
  type_tmp = argInit_real_T();
  // Call the entry-point 'window_gen'.
  window_gen(type_tmp, type_tmp, window);
}

//
// Arguments    : int argc
//                char **argv
// Return Type  : int
//
int main(int, char **)
{
  // The initialize function is being called automatically from your entry-point
  // function. So, a call to initialize is not included here. Invoke the
  // entry-point functions.
  // You can call entry-point functions multiple times.
  main_window_gen();
  // Terminate the application.
  // You do not need to do this more than one time.
  window_gen_terminate();
  return 0;
}

//
// File trailer for main.cpp
//
// [EOF]
//
