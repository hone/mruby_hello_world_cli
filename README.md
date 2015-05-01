# mruby Hello World CLI
This is an example of how to build a single file CLI binary using mruby.

## Compiling
To compile just run the compile rake task.

```sh
$ rake compile
```

## Running the app
After the app is built, you can execute it.

```sh
$ bin/hello_world
hello world
$ bin/hello_world chancancode
hello chancancode
```

## Testing
To run the tests just run the rake task.

```sh
$ rake test
```

## Building a CLI
The app is built from two parts a C wrapper in `src/` and a mruby part in `mrblib/`. The C wrapper is fairly minimal and executes the mruby code and instantiates ARGV and passes it to the mruby code. The mruby bit is the actual code you see being run. `build_config.rb` instructs mruby on which files to include. For this example, we're only printing things, so we opted to only include that bit.
