#include <stdlib.h>
#include <stdio.h>

/* Include the mruby header */
#include <mruby.h>
#include <mruby/irep.h>
#include <mruby/array.h>

int main(int argc, char *argv[])
{
  mrb_state *mrb = mrb_open();
  mrbc_context *c;
  mrb_value v;
  mrb_value ARGV;
  int i;

  ARGV = mrb_ary_new_capa(mrb, argc);
  for (i = 0; i < argc; i++) {
    mrb_ary_push(mrb, ARGV, mrb_str_new_cstr(mrb, argv[i]));
  }
  mrb_define_global_const(mrb, "ARGV", ARGV);

  c = mrbc_context_new(mrb);
  mrb_load_irep_cxt(mrb, hello_world, c);
  mrbc_context_free(mrb, c);
  mrb_close(mrb);
  return 0;
}
