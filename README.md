Currently I use `home-manager` as a declative approach to manager user level
programs and their configurations. It can be deployed across multiple machines
with different architectures and host operating systems.

The installed software and configurations therefore stay tied to the
respective user environment. Since there is substancial overlap between 
how to manage software on NixOS, macOS, and other linux distributions,
`home-manager` is a good compromise for me and quite portable and isolate user 
environments. For a comparison and combination of home manager and managing
system-level installations via NixOS modules,
read [`https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager`](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager).

I currently use it to take care of:

- my ARM64/aarch64/silicon macbook M2:

  ```sh
  cd ~/.config/home-manager
  nix flake update
  home-manager switch .#philipp-aarch64-darwin
  ```

- then with small adjustments a small homelab server running Rocky linux 8.10:

  ```sh
  home-manager switch --flake .#spectral-cockpit-x86_64-linux
  ```

# Update software and activate configuration

```sh
git clone Flakes: per-system configuration
```

```sh
cd ~/.config/home-manager
nix flake update
home-manager switch
```

# Caveats

There is currently limits to how to to make a `home-manager` configuration
system-agnostic. I followed a hack to use attributes in `homeConfigurations`
and a selector `#<username>-<arch>` to select from this list.

E.g 
```sh
home-manager switch --flake .#philipp-aarch64-darwin
```

This is explained a bit better here: https://github.com/Evertras/simple-homemanager/blob/main/05-explain-outputs-body.md

This is sort of a single flake setup 

Since all here is set up custom, opinionated, and inspired by various 
sources (forgot them all) I recommend reading up more about principles e.g. 

- The hack to combine user and architecture:
  - [NixOS Discourse: "Strategy to use same config at work and home"](https://discourse.nixos.org/t/strategy-to-use-same-config-at-work-and-home/34317/2)

  - [Related GitHub issue: "Flakes: per-system configuration"](https://github.com/nix-community/home-manager/issues/3075)

- [Brandon Fulljames : "A practical guide to getting started with home manager with flakes and all that 2024 goodness"](https://github.com/evertras/simple-homemanager)
