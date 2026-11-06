{
  description = "Marlin firmware build shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux"; # change if needed
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "marlin-skr14";

        packages = with pkgs; [
          platformio # FHS-wrapped, so downloaded toolchains work on NixOS
          git
        ];

        shellHook = ''
          echo "Marlin build shell ready."
          echo "  pio run -e LPC1768    # SKR 1.4 (100 MHz)"
          echo "  pio run -e LPC1769    # SKR 1.4 Turbo (120 MHz)"
          echo "  output: .pio/build/<env>/firmware.bin"
        '';
      };
    };
}
