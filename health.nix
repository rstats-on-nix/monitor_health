let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/refs/heads/master.tar.gz") {};
 system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocales nix;
};
 r_packages = builtins.attrValues {
  inherit (pkgs.rPackages)
    callr ps bit64 rstudioapi bit vroom broom systemfonts clipr rematch2
    ggplot2 arrow duckdb collapse kit icosa sf terra stars devtools openssl
    haven rematch knitr munsell RColorBrewer readxl colorspace generics tzdb
    later dplyr cli fs evaluate crayon mime ragg cachem tinytex fontawesome
    lubridate processx data_table yaml rappdirs httr readr hms highr textshaping
    memoise RcppEigen nloptr igraph rJava RCurl RSQLite rstan rlang lifecycle
    shiny dbplyr base64enc prettyunits xml2 progress askpass sys
    tidyr curl cpp11 DBI rprojroot backports gargle blob selectr promises
    Rcpp xfun stringr tidyselect tidyverse htmltools purrr stringi
    timechange cellranger modelr zoo forcats rvest htmlwidgets scales pkgconfig
    vctrs glue tibble pillar jsonlite magrittr withr R6 fansi utf8 fastmap bslib
    viridisLite gtable sass labeling isoband rmarkdown digest jquerylib farver
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
