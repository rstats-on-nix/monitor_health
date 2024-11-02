let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/refs/heads/master.tar.gz") {};
 system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocales nix;
};
 r_packages = builtins.attrValues {
  inherit (pkgs.rPackages)
    rlang lifecycle ggplot2 dplyr cli vctrs glue tibble pillar jsonlite magrittr withr R6 fansi utf8 scales pkgconfig Rcpp xfun stringr tidyselect tidyverse htmltools purrr tidyr curl cpp11 knitr munsell RColorBrewer readxl colorspace generics viridisLite gtable sass labeling isoband rmarkdown digest jquerylib farver fastmap bslib fs evaluate crayon mime ragg cachem tinytex fontawesome stringi memoise data_table yaml rappdirs httr readr hms highr textshaping base64enc prettyunits openssl xml2 progress askpass sys lubridate processx tzdb callr ps bit64 rstudioapi bit vroom broom systemfonts clipr rematch2 haven rematch timechange cellranger modelr zoo forcats rvest htmlwidgets dbplyr DBI rprojroot backports gargle blob selectr promises later
    ;
};
 wrapped_pkgs = pkgs.rWrapper.override {
  packages = [ r_packages ];
};
  in
  pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [ system_packages r_packages wrapped_pkgs ];

  }
