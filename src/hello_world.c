#include <stdlib.h>
#include <stdio.h>

/* Include the mruby header */
#include <mruby.h>
#include <mruby/irep.h>

int main(void)
{
  mrb_state *mrb = mrb_open();
  mrbc_context *c;
  mrb_value v;

  c = mrbc_context_new(mrb);
  mrb_load_irep_cxt(mrb, hello_world, c);
  mrbc_context_free(mrb, c);
  return 0;
}
