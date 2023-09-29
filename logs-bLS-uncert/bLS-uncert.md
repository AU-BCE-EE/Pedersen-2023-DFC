---
title: 'bLS emission uncertainty'
output: pdf_document
author: Sasha D. Hafner
date: "29 September, 2023"
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

With correction


```r
txtplot(wd$ct, wd$NH3_west_corr, height = 40)
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
##    |                                                           |
## 30 +                                                           +
##    |                                                           |
##    |                                                           |
##    |                                                           |
##    |  *                                                        |
##    |   *                                                       |
##    |                                                           |
##    |   *                                                       |
##    |   *                                                       |
## 20 +                                                           +
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
##    |  *            **     ****      * **  *   **  **********   |
##  0 +                                                           +
##    +---+---------+---------+---------+---------+---------+-----+
##        0        50        100       150       200       250
```

```r
txtplot(wd$ct, wd$NH3_east_corr, height = 40)
```

```
##     +---+---------+---------+---------+---------+---------+----+
##     |                                                          |
##     |                                   *                      |
##   2 +                                   *                      +
##     |                                                          |
##     |                                   **                     |
##     |            *                       *                     |
##     |           *                                              |
##     |                                                          |
##     |                                       *                  |
##     |                                    *   *                 |
##     |            *                      *                      |
## 1.5 +                                       *                  +
##     |                                      *                   |
##     |                                       *                  |
##     |           *                          * *                 |
##     |                                    * ***                 |
##     |           **                         ***                 |
##     |            *                         ***                 |
##     |     **     ***                                           |
##   1 +  * ***     ***                *        *                 +
##     |  ******    * *                **  ****     *             |
##     |  *****      ***               *   * *     **             |
##     |  *    *   * ****             ***   *   *                 |
##     |  *    *       ***            ** ** *    * **             |
##     |       *       * *              **  **   * **             |
##     |       ** *      *            * *** **   * ***            |
##     |        ****     **           *  **  **  ****             |
## 0.5 +          **      ***           ***  *   ** *             +
##     |           *      ****        * * *  *   ** **            |
##     |                    **      *    **         **            |
##     |                     *      *** * *       *  *            |
##     |                     **   *  **   *       *  **   *   *   |
##     |                      **  *****           *  **  ** ***   |
##     |                       * ******           *   *********   |
##     |                       *** *                 ***** ***    |
##   0 +                        *                      ***   *    +
##     |                                                          |
##     +---+---------+---------+---------+---------+---------+----+
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
Compare concentrations after emission.


```r
head(wd[, .(Time, NH3_west, NH3_east, NH3_bg, dNH3_west, dNH3_east, )])
```

```
## Error in do_j_names(jsub): Item 7 of the .() or list() passed to j is missing
```

```r
tail(wd[, .(Time, NH3_west, NH3_east, NH3_bg, dNH3_west, dNH3_east, )])
```

```
## Error in do_j_names(jsub): Item 7 of the .() or list() passed to j is missing
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
y
```

```
##      east      west        bg 
## 1.2352963 0.9096533 0.5311799
```

```r
sb2 <- sd(y)
sb2
```

```
## [1] 0.3523884
```

Check for correlation between pre-emission measurements and corrected post-emission values.


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

No real correlation here, i.e., no evidence from post-emission period that differences pre-emission reflected long-term bias.
But also there could still be effects of slurry application, so really we don't know.

Anyway, let's use sd based on corrected values.


```r
y <- unlist(wd[Time >= as.POSIXct('2022-12-04 00:00:00 UTC'), .(east = mean(na.omit(NH3_east_corr)), west = mean(na.omit(NH3_west_corr)), bg = mean(na.omit(NH3_bg)))])
y
```

```
##      east      west        bg 
## 0.1392963 1.4606533 0.5311799
```

```r
sb2 <- sd(y)
sb2
```

```
## [1] 0.6786602
```

Check for correlation between pre-emission measurements and corrected post-emission values.


```r
txtplot(x, y)
```

```
## 1.5 +---------+---------------+----------------+---------------+
##     |  *                                                       |
##     |                                                          |
##     |                                                          |
##     |                                                          |
##   1 +                                                          +
##     |                                                          |
##     |                                                          |
##     |                                                          |
##     |                                                          |
## 0.5 +                    *                                     +
##     |                                                          |
##     |                                                          |
##     |                                                       *  |
##     +---------+---------------+----------------+---------------+
##              0.5              1               1.5              2
```

Interesting there is a negative correlation there, suggests maybe the correction was too large, not representative, but who knows!

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
x
```

```
## east west   bg 
## 1.92 0.27 0.82
```

```r
y
```

```
##      east      west        bg 
## 0.1392963 1.4606533 0.5311799
```

```r
sb1
```

```
## [1] 1.296255
```

```r
sb2
```

```
## [1] 0.6786602
```

```r
sb <- sd(c(x, y))
sb
```

```
## [1] 0.7016497
```

TAN application rate (kg N / ha)


```r
tan.app <- 67
```

Use CE = 3.03, average over 5 days.


```r
ce <- 3.03
```

Uncertainty over 5 days (approximate 95% CI) (micro g / m3 * m / s * s = micro g / m2).

1800 s = dt (0.5 hours), 48 = number of intervals in 1 day, 5 = days

Units below

```
 micro g NH3 / m3  *  g N / g NH3     * m / s   *    s / int  *  int / d   *   d --> micro g N / m2
     sb            * 14.0067 / 17.031 * 1/ce    *     1800    *     48     *   5
```


```r
u <- 2 * sb * 14.0067 / 17.031 / ce * 1800 * 48 * 5
u
```

```
## [1] 164545.9
```

Convert to kg / ha.

* 1E6 micro g / g 
* 1E3 g / kg
* 1E4 m2 / ha

Units:

```
micro g / m2 *  g / micro g * kg / g  *   m2 / ha --> kg/ha  
     u       *  1/1E6       *  1/1E3  *   1E4      
```


```r
u2 <- u / 1E6 / 1E3 * 1E4
u2
```

```
## [1] 1.645459
```

Express as % of applied TAN


```r
u3 <- u2 / tan.app * 100
u3
```

```
## [1] 2.455909
```

Now, for the relative reductions, we might again consider that simultaneous extremes are unlikely.
So a combined value is:


```r
cu <- sqrt(2 * u3^2)
cu
```

```
## [1] 3.47318
```

But I cannot figure out how to use this, because we want a *relative* not absolute reduction (same problem with DFC results, solved by log transformation).

So, looking at extremes, we get:


```r
100 * (1 - (0.23 + u3) / (8.77 - u3))
```

```
## [1] 57.46166
```

```r
100 * (1 - (0.23 - u3) / (8.77 + u3))
```

```
## [1] 119.8283
```

So 57% to 120% (100%) reduction based on emission over 5 days.

While mean is:


```r
100 * (1 - 0.23 / 8.77)
```

```
## [1] 97.37742
```

Try parametric bootstrap approach.
Convert CI to standard deviation for IN and TH.


```r
s3 <- u3 / 2
eth <- rnorm(10000, mean = 8.77, sd = s3)
ein <- rnorm(10000, mean = 0.23, sd = s3)
rred <- 100 * (1 - ein / eth)
quantile(rred, c(0.05, 0.95))
```

```
##        5%       95% 
##  74.05834 121.17633
```

That gives a 74% to 121% (100%) range.

