{
  inputs = {
    dream2nix.url = "github:nix-community/dream2nix";
    nixpkgs.follows = "dream2nix/nixpkgs";
    src.url = "git+ssh://git@github.com/primait/suite_py";
    src.flake = false;
  };

  outputs = { self, dream2nix, nixpkgs, src }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    dream2nix.lib.makeFlakeOutputs {
      systems = [ system ]; # <- This line.
      source = src;
      config.projectRoot = ./.;
      # sourceOverrides = oldSources: pkgs.lib.debug.traceSeq (builtins.attrNames oldSources.pyreadline) oldSources;
      sourceOverrides = oldSources: {
        pyreadline."2.1.zip" = pkgs.fetchzip {
          url = "https://files.pythonhosted.org/packages/bc/7c/d724ef1ec3ab2125f38a1d53285745445ec4a8f19b9bb0761b4064316679/pyreadline-2.1.zip";
          sha256 = "sha256-sS/hJ1Igr1zFktthLOjHGVCY6SVa81EwO7u4QLL7/vM=";
        };
      };
      packageOverrides = {
        suite-py = {
          patch-pyreadline-format = {
            overrideAttrs = oldAttrs: (
              let
                patchCp = (attrs: attrs // { buildPhase = (builtins.replaceStrings [ "cp $file" ] [ "cp -r $file" ] attrs.buildPhase); });
              in
              pkgs.lib.debug.traceSeq oldAttrs.installPhase (patchCp oldAttrs)
            );
          };
        };
      };
      projects.suite-py = {
        name = "suite-py";
        subsystem = "python";
        translator = "poetry";
        subsystemInfo.system = system;
        subsystemInfo.pythonVersion = "3.10";
      };

    };
}
