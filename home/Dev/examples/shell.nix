# Example for per-project environments using the nix-shell tool.
# Save this as shell.nix
with import <nixpkgs> {};
runCommand "dummy" {
  # The packages we want in our environment
  buildInputs = [
    go
    python3
    pkgconfig
  ];
  # nix-shell looks for this (optional) 'shellHook' attribute on the target
  # derivation, which is then evaluated in the new shell.
  shellHook = ''
    echo "Hey look, we're doing some setup stuff!"
    FOO=BAR
  '';
}
"" # <-- There's no need to specify a build command,
   #     since nix-shell won't try to build this package.