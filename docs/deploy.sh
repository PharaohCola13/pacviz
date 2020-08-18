#! /bin/bash.sh

Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook', clean=TRUE, new_session = TRUE)"

git checkout gh-pages
git add --all
git commit -m "update book"
git push origin gh-pages
git checkout master
