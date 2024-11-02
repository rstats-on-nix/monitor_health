let
 pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/976fa3369d722e76f37c77493d99829540d43845.tar.gz") {};
  
  git_archive_pkgs = [
    (pkgs.rPackages.buildRPackage {
      name = "cranlogs";
      src = pkgs.fetchgit {
        url = "https://github.com/r-hub/cranlogs/";
        rev = "c02280c7b4c6d77ff5500f80e15118edad5d94dc";
        sha256 = "sha256-t/gls1TZ6ER0+TsEbHmKCWUqPgD2fl0YHX5f4DPe3Ks=";
      };
      propagatedBuildInputs = builtins.attrValues {
        inherit (pkgs.rPackages) 
          httr
          jsonlite;
      };
    })
   ];
   
  system_packages = builtins.attrValues {
    inherit (pkgs) 
      glibcLocales
      nix
      R;
  };

  r_packages = builtins.attrValues {
    inherit (pkgs.rPackages) 
      dplyr;
  };
  
in

pkgs.mkShell {
  LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
  LANG = "en_US.UTF-8";
   LC_ALL = "en_US.UTF-8";
   LC_TIME = "en_US.UTF-8";
   LC_MONETARY = "en_US.UTF-8";
   LC_PAPER = "en_US.UTF-8";
   LC_MEASUREMENT = "en_US.UTF-8";

  buildInputs = [ git_archive_pkgs   system_packages ];
  
}