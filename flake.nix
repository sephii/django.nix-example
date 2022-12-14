{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    django-nix.url = "github:sephii/django.nix";
    example_project.url = "github:sephii/django-nix-package-example";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = { nixpkgs, poetry2nix, django-nix, example_project, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ poetry2nix.overlay example_project.overlays.${system}.default ];
      };
    in {
      nixosConfigurations = {
        example-system = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          modules = [
            django-nix.nixosModules.djangonix
            {
              system.stateVersion = "22.11";
              environment.systemPackages = [
                pkgs.vim
                pkgs.httpie
              ];
              users.users.root.initialPassword = "root";

              django.sites.example_prod = {
                package = pkgs.example_project.backend.server;
                staticFilesPackage = pkgs.example_project.backend.static;
                hostname = "localhost";
                disableACME = true;
                settingsModule = "example_project.config.settings.base";
                wsgiModule = "example_project.config.wsgi";
              };
            }
          ];
        };
      };
    };
}
