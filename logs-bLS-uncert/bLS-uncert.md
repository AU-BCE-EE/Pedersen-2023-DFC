---
title: 'bLS emission uncertainty'
output: pdf_document
author: Sasha D. Hafner
date: "27 September, 2023"
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
sb <- sqrt(2 * sd(x))
sb
```

```
## [1] 1.296255
```

TAN application rate (kg N / ha)


```r
tan.app <- 67
```

Use CE = 3.2, average of day 1 and 2


```r
ce <- 3.2
```

Uncertainty over 2 days (approximate 95% CI) (micro g / m3 * m / s * s = micro g / m2).

1800 s = dt (0.5 hours), 48 = number of intervals in 1 day, 2 = days


```r
u <- 2 * sb / ce * 1800 * 48 * 2
u
```

```
## [1] 139995.6
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
## [1] 1.399956
```

Express as % of applied TAN


```r
u3 <- u2 / tan.app * 100
u3
```

```
## [1] 2.089486
```

Now, for the relative reductions, we might again consider that simultaneous extremes are unlikely.
So a combined value is:


```r
cu <- sqrt(2 * u3^2)
cu
```

```
## [1] 2.95498
```

But I cannot figure out how to use this, because we want a *relative* not absolute reduction (same problem with DFC results, solved by log-transformation).

Over 5 days.



```r
ce <- 3.0
u <- 2 * sb / ce * 1800 * 48 * 5
u2 <- u / 1E6 / 1E3 * 1E4
u3 <- u2 / tan.app * 100
u3
```

```
## [1] 5.571963
```




