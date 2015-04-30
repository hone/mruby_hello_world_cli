#include <stdlib.h>
#include <stdio.h>

/* Include the mruby header */
#include <mruby.h>
#include <mruby/compile.h>

int main(void)
{
  mrb_state *mrb = mrb_open();
  char code[] = "p 'hello world!'";
  printf("Executing Ruby code with mruby!\n");

  mrb_load_string(mrb, code);
  return 0;
}
