FROM hone/mruby-cli

# setup user account based off host uid/gid
RUN groupadd -g 1000 -r mruby && useradd -u 1000 -g mruby mruby
USER mruby
