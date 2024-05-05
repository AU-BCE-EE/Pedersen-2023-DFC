

df1$app.meth <- mapvalues(df1$app.meth, from = 'TH', to = 'Trailing hose')
df2$app.meth <- mapvalues(df2$app.meth, from = 'TH', to = 'Trailing hose')
df1$app.meth <- mapvalues(df1$app.meth, from = 'IN', to = 'Injection')
df2$app.meth <- mapvalues(df2$app.meth, from = 'IN', to = 'Injection')

df1$in1 <- factor(interaction(df1$app.meth, df1$treat))
in2 <- factor(interaction(df2$app.meth, df2$treat))

df1$in1 <- gsub('\\.', ' ', df1$in1)
in2 <- gsub('\\.', ' ', in2)

df1$in1 <- factor(df1$in1, levels = c('Trailing hose DFC', 'Trailing hose WT', 'Trailing hose bLS', 'Injection DFC', 'Injection bLS'))

# Flux
ggplot(df1, aes(elapsed.time, flux, color = in1)) + 
  geom_point(size = 0.5) + 
  geom_line(aes(group = interaction(tk, app.meth, id)), size = 0.5) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste(NH[3]-N, '   flux (g  ',  min^-1, ' ', m^-2, ')'))) + 
  xlab('Time after digestate application (hours)') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-field-trials/flux', height = 4, width = 7) 

ggplot(df1, aes(elapsed.time, flux.perc, color = in1)) + 
  geom_point(size = 0.5) + 
  geom_line(aes(group = interaction(tk, app.meth, id)), size = 0.5) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste('TAN (%  ',  min^-1,')'))) + 
  xlab('Time after digestate application (hours)') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-field-trials/flux_perc', height = 4, width = 7) 

# # conference poster plot
# df1$tkA <- df1$tk
# df1$tkA <- mapvalues(df1$tkA, from = 'A', to = 'A: Manual')
# df1$tkA <- mapvalues(df1$tkA, from = 'B', to = 'B: 30-m boom')
# df1$tkA <- mapvalues(df1$tkA, from = 'C', to = 'C: 3-m boom')
# 
# df1$app.methA <- df1$app.meth
# df1$app.methA <- mapvalues(df1$app.methA, from = 'Trailing hose', to = 'TH')
# df1$app.methA <- mapvalues(df1$app.methA, from = 'Injection', to = 'IN')
# df1$in1A <- factor(interaction(df1$app.methA, df1$treat))
# df1$in1A <- gsub('\\.', ' ', df1$in1A)
# 
# df1$in1A <- factor(df1$in1A, levels = c('TH DFC', 'TH WT', 'TH bLS', 'IN DFC', 'IN bLS'))
# 
# ggplot(df1, aes(elapsed.time, flux.perc, color = in1A)) + 
#   geom_point(size = 0.5) + 
#   geom_line(aes(group = interaction(tk, app.meth, id))) + 
#   facet_wrap(~ tkA, scale = 'free') + 
#   theme_bw() + 
#   scale_color_brewer(palette = 'Set1') + 
#   ylab(expression(paste('TAN (%  ',  min^-1,')'))) + 
#   xlab('Time after slurry digestate application (hours)') + 
#   theme(legend.position = 'bottom', legend.title = element_blank())
# ggsave2x('../plots-field-trials/flux_perc_EGU', height = 3, width = 5) 

# Cum emis
ggplot(df1, aes(elapsed.time, cum.emis.perc, color = in1)) + 
  geom_point(size = 0.5) + 
  geom_line(aes(group = interaction(tk, app.meth, id)), size = 0.5) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste('Cumulative  ', NH[3]-N, '  (% TAN)'))) +
  xlab('Time after digestate application (hours)') + 
  theme(legend.title = element_blank(), legend.position = 'bottom')
ggsave2x('../plots-field-trials/cum_emis_perc', height = 4, width = 7)

ggplot(df2, aes(elapsed.time, cum.emis.mn.perc, fill = in2, color = in2)) + 
  geom_point(size = 0.5) + 
  geom_line(aes(group = in2), size = 0.5) + 
  geom_ribbon(aes(ymin = cum.emis.mn.perc - cum.emis.sd.perc, ymax = cum.emis.mn.perc + cum.emis.sd.perc, group = in2), alpha = 0.3, color = NA) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + scale_fill_brewer(palette = 'Set1') + 
  ylab(expression(paste('Cumulative  ', NH[3]-N, '  (% TAN)'))) +
  xlab('Time after digestate application (hours)') + 
  theme(legend.title = element_blank(), legend.position = 'bottom')
ggsave2x('../plots-field-trials/cum_emis_mn_perc', height = 4, width = 7)

# Weather 
weather$what <- mapvalues(weather$what, from = 'airT', to = 'Temperature')
weather$what <- mapvalues(weather$what, from = 'WS', to = 'Wind speed')
weather$what <- mapvalues(weather$what, from = 'prec', to = 'Precipitation')
weather <- weather[weather$elapsed.time <= 120, ]

ggplot(na.omit(weather), aes(elapsed.time, num, color = what)) + 
  geom_line() + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') +
  xlab('Time after digestate application (hours)') + 
  ylab(expression(paste("Temperature ( ",degree,"C) / Wind speed ( m ", s^-1, ') / Precipitation (mm)'))) +
  theme(legend.position = 'bottom', legend.title = element_blank()) + 
  ylim(0, 13)
ggsave2x('../plots-field-trials/weather', height = 6, width = 7)


# combined plot of flux and weather

weather$what <- mapvalues(weather$what, from = 'airT', to = 'Temperature')
weather$what <- mapvalues(weather$what, from = 'prec', to = 'Precipitation')
weather$what <- mapvalues(weather$what, from = 'WS', to = 'Wind speed')

pflux <- ggplot(df1, aes(elapsed.time, flux.perc, color = in1)) + 
  geom_point(size = 0.5) + 
  geom_line(aes(group = interaction(tk, app.meth, id)), size = 0.5) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste('TAN (%  ',  min^-1,')'))) + 
  theme(legend.title = element_blank()) + 
  theme(axis.text.x = element_blank(), axis.title.x = element_blank(), axis.ticks.x = element_blank())
print(pflux)

fclim <- ggplot(na.omit(weather), aes(elapsed.time, num, color = what)) + 
  geom_line() + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') +
  xlab('Time after digestate application (hours)') + 
  ylab(expression(paste("Temp. (",degree,"C) / WS ( m ", s^-1, ') / Prec. (mm)'))) +
  theme(legend.title = element_blank()) + 
  ylim(0, 13) + 
  theme(strip.text.x = element_blank())
print(fclim)

# Note that ggave (so ggsave2x) won't work
pdf('../plots-field-trials/flux_weather.pdf', height = 5, width = 8)
grid::grid.draw(rbind(ggplotGrob(pflux), ggplotGrob(fclim)))
dev.off()

#### one with four pannels

df1$tk1 <- df1$tk
df1$tk1[df1$tk == 'C' & df1$app.meth == 'Injection'] <- 'C '

dfw <- weather[weather$tk == 'C', ]
dfw$tk <- 'C '
weather <- rbind(weather, dfw)

pflux <- ggplot(df1, aes(elapsed.time, flux.perc, color = in1)) + 
  geom_point(size = 0.5) + 
  geom_line(aes(group = interaction(tk, app.meth, id)), size = 0.5) + 
  facet_wrap(~ tk1, scale = 'free', ncol = 4) + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste('Flux (% TAN  ',  min^-1,')'))) + 
  theme(legend.title = element_blank()) + 
  theme(axis.text.x = element_blank(), axis.title.x = element_blank(), axis.ticks.x = element_blank())
print(pflux)

fclim <- ggplot(na.omit(weather), aes(elapsed.time, num, color = what)) + 
  geom_line() + 
  facet_wrap(~ tk, scale = 'free', ncol = 4) + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') +
  xlab('Time after digestate application (hours)') + 
  ylab(expression(paste("Temp. (",degree,"C) / WS ( m ", s^-1, ') / Prec. (mm)'))) +
  theme(legend.title = element_blank()) + 
  ylim(0, 13) + 
  theme(strip.text.x = element_blank())
print(fclim)

# Note that ggave (so ggsave2x) won't work
pdf('../plots-field-trials/flux_weather1.pdf', height = 5, width = 8)
grid::grid.draw(rbind(ggplotGrob(pflux), ggplotGrob(fclim)))
dev.off()
