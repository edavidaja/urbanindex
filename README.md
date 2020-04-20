
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
#>         GEOID pop_within_5_mi
#> 1 01001020100        3609.263
#> 2 01001020200        3518.769
#> 3 01001020300        3794.940
#> 4 01001020400        4051.639
#> 5 01001020500        4294.309
#> 6 01001020600        3183.779
```

## garden of forking paths

a differently wrong approach uses `st_is_within_distance` to identify
tract centroids within five miles of each other, available on the
[centroid-self-join](https://github.com/edavidaja/urbanindex/tree/centroid-self-join)
branch
