{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

#  overlays = [
#    (final: prev: {
#      rPackages = prev.rPackages or {} // {
#        ggradar = final.callPackage ./pkgs/ggradar.nix {};
#        hdWGCNA = final.callPackage ./pkgs/hdWGCNA.nix {};
#        Libra = final.callPackage ./pkgs/Libra.nix {};
#        loomR = final.callPackage ./pkgs/loomR.nix {};
#        monocle3 = final.callPackage ./pkgs/monocle3.nix {};
#        presto = final.callPackage ./pkgs/presto.nix {};
#        SeuratData = final.callPackage ./pkgs/SeuratData.nix {};
#        SeuratDisk = final.callPackage ./pkgs/SeuratDisk.nix {};
#        seuratwrappers = final.callPackage ./pkgs/seuratwrappers.nix {};
#      };
#     })
#  ];

  packages = let
    myRPackages = with pkgs.rPackages; [
      easypackages
      Seurat
      SingleCellExperiment
      scater
      patchwork
      sctransform
      dplyr
      ggplot2
      ggraph
      igraph
      tidyverse
      data_tree
      HGNChelper
      magrittr
      UCell
      corrplot
      cowplot
      repr
      IRdisplay
      IRkernel
      DESeq2
      gprofiler2
      enrichR
      clustree
      openxlsx
      glmGamPoi
      devtools
      UpSetR
      harmony
    ];
    bio-flake-packages = with inputs.bio-flake.packages."x86_64-linux"; [
      ggradar
      hdWGCNA
      Libra
      loomR
      monocle3
      presto
      SeuratData 
      SeuratDisk
      seuratwrappers
    ];
  in [ 
    pkgs.git
    pkgs.R
  ] ++ myRPackages
  ++ bio-flake-packages;

  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    git --version
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
