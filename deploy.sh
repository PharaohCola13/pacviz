#! bin/bash

while getopts "pdt" opt; do
	case "${opt}" in
    p)
				# Rscript -e "attachment::att_amend_desc()"
				Rscript -e "usethis::use_tidy_description()"
				Rscript -e "devtools::check(document=TRUE, manual=TRUE, cran=TRUE, vignettes=TRUE)"
        Rscript -e "devtools::build_manual(pkg ='.', path='./man')"
				;;
    t)
        cd ./docs/
        Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook', clean=TRUE, new_session = TRUE)"
			;;
		d)
				cd ./docs/
				Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook', clean=TRUE, new_session = TRUE)"
        git checkout gh-pages
        git add --all
        git commit -m "update book"
        git push origin gh-pages
        git checkout master
        ;;
  esac
done
