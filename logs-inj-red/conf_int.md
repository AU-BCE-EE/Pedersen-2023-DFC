---
title: 'Injection reduction confidence interval'
output: pdf_document
author: Sasha D. Hafner
date: "26 September, 2023"
---

Data


```r
dat
```

```
##      tk id cum.emis.perc app.meth
## 1022  C 10      7.391289       IN
## 1112  C  2      5.759458       IN
## 1202  C  3      3.031186       IN
## 1292  C  4      2.563422       IN
## 1382  C  5      8.318043       IN
## 1472  C  6      1.473785       IN
## 1562  C  8      4.143501       IN
## 1652  C  1     38.050421       TH
## 1742  C  3     35.638613       TH
## 1832  C  4     44.470647       TH
## 1922  C  5     44.120937       TH
## 2012  C  6     52.382874       TH
## 2102  C  8     42.150399       TH
```


```r
dat$app.meth <- factor(dat$app.meth, levels = c('TH', 'IN'))
```


Transformation for relative effect


```r
dat$le <- log10(dat$cum.emis.perc)
```


```r
m1 <- t.test(cum.emis.perc ~ app.meth, data = dat)
m1
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  cum.emis.perc by app.meth
## t = 14.811, df = 6.6396, p-value = 2.475e-06
## alternative hypothesis: true difference in means between group TH and group IN is not equal to 0
## 95 percent confidence interval:
##  31.97801 44.28928
## sample estimates:
## mean in group TH mean in group IN 
##        42.802315         4.668669
```

Mean reduction:


```r
as.numeric(1 - m1$estimate[2] / m1$estimate[1])
```

```
## [1] 0.8909248
```
89%

Confidence interval on difference:


```r
m1$conf.int / m1$estimate[1]
```

```
## [1] 0.7471094 1.0347403
## attr(,"conf.level")
## [1] 0.95
```

74.7-100% reduction.


Use log-transformed values.
Negative emission not possible with the transformation.


```r
m2 <- t.test(le ~ app.meth, data = dat)
1 - 10^(-m2$conf.int)
```

```
## [1] 0.8317578 0.9469140
## attr(,"conf.level")
## [1] 0.95
```

83-95% reduction.

lm instead


```r
m3 <- lm(cum.emis.perc ~ app.meth, data = dat)
confint(m3)
```

```
##                 2.5 %    97.5 %
## (Intercept)  38.87487  46.72976
## app.methIN  -43.48585 -32.78144
```

Not exactly same as m1 but close.

lm with log transformation.


```r
m4 <- lm(le ~ app.meth, data = dat)
1- 10^confint(m4)
```

```
##                   2.5 %      97.5 %
## (Intercept) -26.8953237 -63.6842290
## app.methIN    0.9467193   0.8323726
```
 83-95% reduction.






