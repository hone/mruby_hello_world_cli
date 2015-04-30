#include <stdlib.h>
#include <stdio.h>

/* Include the mruby header */
#include <mruby.h>
#include <mruby/compile.h>

int main(void)
{
  mrb_state *mrb = mrb_open();
  mrbc_context *c;
  mrb_value v;
  FILE *mrb_file = fopen("mrblib/hello_world.rb", "r");

  c = mrbc_context_new(mrb);
  mrb_load_file_cxt(mrb, mrb_file, c);
  mrbc_context_free(mrb, c);
  return 0;
}
