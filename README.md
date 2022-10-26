# dotnixpkgs

Like dotfiles, but with [home-manager](https://github.com/nix-community/home-manager).

## Bootstrapping

Install nix:

```
$ sh <(curl -L https://nixos.org/nix/install) --no-daemon
$ . /home/jtremesay/.nix-profile/etc/profile.d/nix.sh
```

Add home-manager channel:

```
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
```

Get the configuration:

```
$ mkdir -p .config/nixpkgs
$ git clone git@github.com:killruana/dotnixpkgs.git .config/nixpkgs
# OR
$ git clone https://github.com/killruana/dotnixpkgs.git .config/nixpkgs
```

First apply of the config:

```
$ NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/$USER/channels${NIX_PATH:+:$NIX_PATH}  nix-shell '<home-manager>' -A install
```

You can now relogin. Next updates of the configuration can be applied with

```
$ home-manager switch
```
