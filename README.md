# django.nix example

This is an example showing how to use [django.nix](https://github.com/sephii/django.nix) to deploy a Django site on
NixOS.

You can run it in a qemu VM using the following commands:

```sh
nixos-rebuild build-vm .#example-system
./result/bin/run-nixos-vm -m 512m
```

Login with user root, password root.

Have a look at [django.nix](https://github.com/sephii/django.nix) and [this Django site](https://github.com/sephii/django-nix-package-example) packaged with Nix for more details.
