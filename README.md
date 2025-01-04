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

- then with small adjustments a small homelab server running Rocky linux 8.10



# Update software and activate configuration

```sh
cd ~/.config/home-manager
nix flake update
home-manager switch
```

# Caveats

There is currently limits to how to to make a `home-manager` configuration
system-agnostic