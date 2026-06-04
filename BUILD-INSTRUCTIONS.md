# Build and deploy artificialLifeR

Open the package root in RStudio.

## 1. Check package name

```r
read.dcf("DESCRIPTION")[, "Package"]
```

It should return:

```text
artificialLifeR
```

## 2. Document and test

```r
devtools::document()
devtools::test()
devtools::install()
```

Restart RStudio, then run:

```r
library(artificialLifeR)
```

## 3. Build pkgdown site

```r
pkgdown::build_site()
file.create("docs/.nojekyll")
```

## 4. GitHub Pages settings

Use:

```text
Settings → Pages → Deploy from a branch → main → /docs
```

## 5. Commit and push

```bash
git add DESCRIPTION NAMESPACE README.md _pkgdown.yml R vignettes pkgdown tests BUILD-INSTRUCTIONS.md LICENSE LICENSE.md
git add -f docs
git commit -m "Create artificialLifeR package and pkgdown site"
git push
```

## Notes

- Keep `README.md` as plain markdown. Do not use R Markdown chunks like ```{r}. Use plain ```r code blocks.
- Keep only one `extra_css` field in `_pkgdown.yml`.
- If GitHub blocks a push because of email privacy, set your GitHub noreply email with `git config --global user.email` and amend the commit author.
