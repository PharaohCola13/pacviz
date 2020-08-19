#! bin/bash

while getopts "dt" opt; do
	case "${opt}" in
    t)
        Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook', clean=TRUE, new_session = TRUE)"
			;;
		d)
				Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook', clean=TRUE, new_session = TRUE)"
        git add --all
        git commit -m "update book"
        git push origin gh-pages
        ;;
  esac
done
