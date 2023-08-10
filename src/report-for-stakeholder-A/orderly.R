orderly2::orderly_strict_mode()

orderly2::orderly_resource("report.Rmd")

orderly2::orderly_dependency(
  "data-analysis",
  "latest",
  c(summary_cov_stat.rds = "summary_cov_stat.rds",
    coverage.png = "coverage.png"))

orderly2::orderly_artefact("Main report", "report.pdf")

library(flextable)
library(dplyr)

rmarkdown::render("report.Rmd")
