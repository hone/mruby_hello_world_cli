# mruby Hello World CLI
This is an example of how to build a single file CLI binary using mruby.

## Setup
You'll need [`docker`](https://docs.docker.com/installation/) and [`docker-compose`](https://docs.docker.com/compose/install/) installed. Run `rake setup` to build a `Dockerfile` and `docker-compose.yml` locally. This container includes all the tools needed to compile mruby on linux (host), OSX (darwin14), and Windows (mingw-w64). We mount the current code directory inside the container as `/home/mruby/code`. Any changes in that directory persist locally.

## Compiling
To compile just run the `docker-compose` task.

```sh
$ docker-compose run compile
```

## Running the app
After the app is built, you can execute it.

```sh
$ mruby/bin/hello_world
hello world
$ mruby/bin/hello_world chancancode
hello chancancode
```

The other platform binaries will be located in `mruby/build/`.

* Linux: `mruby/build/host/bin/hello_world`
* OS X: `mruby/build/x86_64-apple-darwin14/bin/hello_world`
* Windows: `mruby/build/mingw-w64/bin/hello_world`

## Debugging
You can run a shell in the docker container to do any debugging you need.

```sh
$ docker-compose run shell
```

## Testing
To run the tests just run the rake task.

```sh
$ rake test
```

## Building a CLI
The app is built from two parts a C wrapper in `src/` and a mruby part in `mrblib/`. The C wrapper is fairly minimal and executes the mruby code and instantiates ARGV and passes it to the mruby code. The mruby bit is the actual code you see being run. `build_config.rb` instructs mruby on which files to include. For this example, we're only printing things, so we opted to only include that bit.
