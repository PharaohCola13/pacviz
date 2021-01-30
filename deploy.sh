#! bin/bash

while getopts "p" opt; do
	case "${opt}" in
    p)
				# Rscript -e "usethis::use_tidy_description()"
				Rscript -e "devtools::check(document=TRUE, manual=TRUE, cran=TRUE, vignettes=TRUE)"
				Rscript -e "devtools::build(manual=TRUE, vignettes=TRUE)"
				;;
  esac
done
