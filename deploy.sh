#! bin/bash


while getopts "pd" opt; do
	case "${opt}" in
    p)
        Rscript -e "devtools::check(document=TRUE, manual=TRUE, cran=TRUE, cleanup=TRUE, vignettes=TRUE)"
        Rscript -e "devtools::build_manual(pkg ='.', path='./man')";;
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
