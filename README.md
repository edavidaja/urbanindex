[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/edavidaja/urbanindex)


<!-- README.md is generated from README.Rmd. Please edit that file -->

# urbanindex

<!-- badges: start -->

<!-- badges: end -->

incorrectly calculating the [538 urbanization
index](https://fivethirtyeight.com/features/how-urban-or-rural-is-your-state-and-what-does-that-mean-for-the-2020-election/)
for each census tract

## inspiration

<https://twitter.com/NateSilver538/status/1200498385125433344>

## Installation

You can install urbanindex from
[github](https://github.com/edavidaja/urbanindex) with:

``` r
install.packages("edavidaja/urbanindex")
```

if that doesn’t work–have you met
[`{renv}`](https://rstudio.github.io/renv/articles/renv.html)?

## Example

``` r
library(urbanindex)
head(pop_within_5_mi)
#>         GEOID pop_within_five population
#> 1 01001020100           58291       1923
#> 2 01001020200           58555       2028
#> 3 01001020300           64819       3476
#> 4 01001020400           68921       3831
#> 5 01001020500           71947       9883
#> 6 01001020600           50997       3705
```

## garden of forking paths

a differently wrong approach uses `st_is_within_distance` to identify
tract centroids within five miles of each other, available on the
[centroid-self-join](https://github.com/edavidaja/urbanindex/tree/centroid-self-join)
branch
