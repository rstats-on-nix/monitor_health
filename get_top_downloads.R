library(cranlogs)

top_downloads <- cran_top_downloads(
  when = "last-month",
  count = 100
)

packages <- top_downloads$package |>
  gsub("\\.", "_", x=_)

for_nix <- paste0(
  packages,
  collapse = " "
)

health_nix <- readLines(
  "health.nix"
)

health_nix <- gsub("PACKAGES_HERE", for_nix, health_nix)

writeLines(health_nix, "health.nix")
