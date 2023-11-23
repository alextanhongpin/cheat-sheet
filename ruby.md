## rbenv to manage your local ruby version

```bash
$ rbenv exec <your_command_here>

# E.g.
$ rbenv exec gem install bundler
$ rbenv exec bundle install
```


## Setting up Ruby on Linux

The only adjustments is adding the flag `--auto-dotfiles`.

```bash
$ curl -L get.rvm.io | bash -s stable --auto-dotfiles
$ source ~/.bash_profile
```


There is issue when running rvm install:

https://stackoverflow.com/questions/72179373/cant-install-ruby-via-rvm-error-running-rvm-make-j4-on-ubuntu-22-04


Run this first:

```bash
$ rvm pkg install openssl
# $ rvm reinstall 2.6.5 --with-openssl-dir=/home/$(whoami)/.rvm/usr
# $ rvm reinstall 2.6.5 --with-openssl-dir=/usr/lib/ssl
$ rvm reinstall 2.6.5 --with-openssl-dir=/opt/openssl-1.1.1q
```

Then run this (see [issue](https://github.com/ffi/ffi/issues/869)):

```bash
$ RUBY_CFLAGS=-DUSE_FFI_CLOSURE_ALLOC rvm install 2.6.5
```

## Run specific test

```bash
$ bundle exec rspec ./path/to/spec.rb
```

