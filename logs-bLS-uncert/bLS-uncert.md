---
title: 'bLS emission uncertainty'
output: pdf_document
author: Sasha D. Hafner
date: "28 September, 2023"
---

Mean CE (s / m).

By day and application method.


```r
dat[day < 6, .(CE_mean = mean(na.omit(CE))), by = .(app.mthd, day)]
```

```
##     app.mthd day  CE_mean
##  1:       TH   0 2.835448
##  2:       TH   1 2.648924
##  3:       TH   2 3.894132
##  4:       TH   3 3.258339
##  5:       TH   4 2.299959
##  6:       TH   5 3.020897
##  7:       IN   0 2.796250
##  8:       IN   1 2.611369
##  9:       IN   2 3.859599
## 10:       IN   3 3.224106
## 11:       IN   4 2.250724
## 12:       IN   5 3.258143
```

Over first 4 days.



```r
dat[day < 5, .(CE_mean = mean(na.omit(CE))), ]
```

```
##     CE_mean
## 1: 3.008301
```

Over first 5 days.



```r
dat[day < 6, .(CE_mean = mean(na.omit(CE))), ]
```

```
##     CE_mean
## 1: 3.034239
```

Estimated standard deviation in bias among instruments (micro g N / m3)


```r
x <- c(east = 1.92, west = 0.27, bg = 0.82)
sd(x)
```

```
## [1] 0.8401389
```

```r
sb1 <- sqrt(2 * sd(x))
sb1
```

```
## [1] 1.296255
```

Consider standard deviation after application (this includes correction).

Look at concentration curves.


```r
txtplot(wd$ct, wd$NH3_west, height = 40)
```

```
##    +---+---------+---------+---------+---------+---------+-----+
##    |                                                           |
## 40 +  *                                                        +
##    |                                                           |
##    |                                                           |
##    |                                                           |
##    |  *                                                        |
##    |  *                                                        |
##    |                                                           |
##    |                                                           |
## 30 +                                                           +
##    |                                                           |
##    |                                                           |
##    |                                                           |
##    |                                                           |
##    |  *                                                        |
##    |   *                                                       |
##    |                                                           |
##    |   *                                                       |
## 20 +   *                                                       +
##    |                                                           |
##    |   *                                                       |
##    |                                                           |
##    |   ***                                                     |
##    |    **                                                     |
##    |    **                                                     |
##    |    *                                                      |
##    |    **                                                     |
## 10 +     *                                                     +
##    |     **                                                    |
##    |      **                                                   |
##    |      **    *                                              |
##    |       *    *                                              |
##    |       *    *                       *  *                   |
##    |       *  *****           ******   ** ****                 |
##    |        **** *********************** ** ********  **       |
##  0 +  *            **     ****      * **  *   **  **********   +
##    |                                                           |
##    +---+---------+---------+---------+---------+---------+-----+
##        0        50        100       150       200       250
```

```r
txtplot(wd$ct, wd$NH3_east, height = 40)
```

```
##     +---+---------+---------+---------+---------+---------+----+
##     |                                                          |
##     |                                   *                      |
##     |                                   *                      |
##     |                                                          |
##   3 +                                   **                     +
##     |            *                       *                     |
##     |           *                                              |
##     |                                                          |
##     |                                       *                  |
##     |                                    *   *                 |
##     |            *                      *                      |
##     |                                       *                  |
## 2.5 +                                      *                   +
##     |                                       *                  |
##     |           *                          * *                 |
##     |                                    * ***                 |
##     |           **                         ***                 |
##     |            *                         ***                 |
##     |     **     ***                                           |
##     |  * ***     ***                *        *                 |
##   2 +  ******    * *                **  ****     *             +
##     |  *****      ***               *   * *     **             |
##     |  *    *   * ****             ***   *   *                 |
##     |  *    *       ***            ** ** *    * **             |
##     |       *       * *              **  **   * **             |
##     |       ** *      *            * *** **   * ***            |
##     |        ****     **           *  **  **  ****             |
##     |          **      ***           ***  *   ** *             |
##     |           *      ****        * * *  *   ** **            |
## 1.5 +                    **      *    **         **            +
##     |                     *      *** * *       *  *            |
##     |                     **   *  **   *       *  **   *   *   |
##     |                      **  *****           *  **  ** ***   |
##     |                       * ******           *   *********   |
##     |                       *** *                 ***** ***    |
##     |                        *                      ***   *    |
##     |                                                          |
##   1 +---+---------+---------+---------+---------+---------+----+
##         0        50        100       150       200       250
```

```r
txtplot(wd$ct, wd$NH3_bg, height = 40)
```

```
##     +---+---------+---------+---------+---------+---------+----+
##     |                                                          |
##     |                                        *                 |
##     |                                        *                 |
##     |                                                          |
##     |                                        *                 |
##     |                                                          |
##     |                                         *                |
## 1.5 +                                                          +
##     |                                        *                 |
##     |                                        **                |
##     |                                                          |
##     |                                        *                 |
##     |                                         *                |
##     |                                                          |
##     |                                         *                |
##     |                                         *  *             |
##     |                                         *  *             |
##     |                                          * *             |
##   1 +                                        *    *            +
##     |            *                       *                     |
##     |  *                                     *  *              |
##     |  **                                *  ** ****            |
##     |  **  **                                  ****            |
##     |  *    *        *                  **  *    **    *       |
##     |   *  *         **                  *  *  **      *       |
##     |  *** **    *   **                 **  *  * ***   **      |
##     |  * ***    *    **                 **       ***  * *      |
##     |  * ** *    *    *                   *    **   * * **     |
## 0.5 +     * *        ***  ***           * ***  *   **** **     +
##     |       *    * * *** **** **    *     ***     *****   **   |
##     |       **   * *** * *    **** **     **      *****  ***   |
##     |        ** *****  ***  ******* **  *  *        * *   **   |
##     |         * * * *  ***  **  ****    *                      |
##     |         **       **         ** ****                      |
##     |          **                  * ***                       |
##     |          **                      **                      |
##     |                                                          |
##     +---+---------+---------+---------+---------+---------+----+
##         0        50        100       150       200       250
```


```r
wd[Time >= as.POSIXct('2022-12-04 00:00:00 UTC'), .(cw = mean(na.omit(NH3_west)), ce = mean(na.omit(NH3_east)), cb = mean(na.omit(NH3_bg)))]
```

```
##           cw       ce        cb
## 1: 0.9096533 1.235296 0.5311799
```

```r
ed[Time >= as.POSIXct('2022-12-04 00:00:00 UTC'), .(cw = mean(na.omit(NH3_west)), ce = mean(na.omit(NH3_east)), cb = mean(na.omit(NH3_bg)))]
```

```
##           cw       ce        cb
## 1: 0.9096533 1.235296 0.5311799
```

```r
y <- unlist(wd[Time >= as.POSIXct('2022-12-04 00:00:00 UTC'), .(east = mean(na.omit(NH3_east)), west = mean(na.omit(NH3_west)), bg = mean(na.omit(NH3_bg)))])
sb2 <- sd(y)
sb2
```

```
## [1] 0.3523884
```


```r
txtplot(x, y)
```

```
##     +---------+---------------+----------------+---------------+
## 1.2 +                                                       *  +
##     |                                                          |
##     |                                                          |
##     |                                                          |
##   1 +                                                          +
##     |                                                          |
##     |  *                                                       |
##     |                                                          |
## 0.8 +                                                          +
##     |                                                          |
##     |                                                          |
## 0.6 +                                                          +
##     |                    *                                     |
##     +---------+---------------+----------------+---------------+
##              0.5              1               1.5              2
```
Number of points.


```r
wd[Time >= as.POSIXct('2022-12-04 00:00:00 UTC'), .(nw = sum(!is.na(NH3_west)), ne = sum(!is.na(NH3_east)), nb = sum(!is.na(NH3_bg)))]
```

```
##    nw ne nb
## 1: 60 60 60
```

Combine sd estimates.


```r
sb <- sd(c(x, y))
```

TAN application rate (kg N / ha)


```r
tan.app <- 67
```

Use CE = 3.0, average over 4 days.


```r
ce <- 3.0
```

Uncertainty over 4 days (approximate 95% CI) (micro g / m3 * m / s * s = micro g / m2).

1800 s = dt (0.5 hours), 48 = number of intervals in 1 day, 4 = days


```r
u <- 2 * sb / ce * 1800 * 48 * 4
u
```

```
## [1] 133496.9
```

Convert to kg / ha.

* 1E6 micro g / g 
* 1E3 g / kg
* 1E4 m2 / ha



```r
u2 <- u / 1E6 / 1E3 * 1E4
u2
```

```
## [1] 1.334969
```

Express as % of applied TAN


```r
u3 <- u2 / tan.app * 100
u3
```

```
## [1] 1.992491
```

Now, for the relative reductions, we might again consider that simultaneous extremes are unlikely.
So a combined value is:


```r
cu <- sqrt(2 * u3^2)
cu
```

```
## [1] 2.817807
```

But I cannot figure out how to use this, because we want a *relative* not absolute reduction (same problem with DFC results, solved by log transformation).

So, looking at extremes, we get:


```r
100 * (1 - (0.3 + u3) / (12 - u3))
```

```
## [1] 77.0923
```

```r
100 * (1 - (0.3 - u3) / (12 + u3))
```

```
## [1] 112.0957
```

So 77% to 100% reduction based on emission over 4 days.
