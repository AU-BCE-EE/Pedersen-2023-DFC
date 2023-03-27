
df1$app.meth <- mapvalues(df1$app.meth, from = 'TH', to = 'Trailing hose')
df2$app.meth <- mapvalues(df2$app.meth, from = 'TH', to = 'Trailing hose')
df1$app.meth <- mapvalues(df1$app.meth, from = 'IN', to = 'Injection')
df2$app.meth <- mapvalues(df2$app.meth, from = 'IN', to = 'Injection')

in1 <- factor(interaction(df1$app.meth, df1$treat))
in2 <- factor(interaction(df2$app.meth, df2$treat))

in1 <- gsub('\\.', ' ', in1)
in2 <- gsub('\\.', ' ', in2)

# Flux
ggplot(df1, aes(elapsed.time, flux, color = in1)) + 
  geom_point(size = 0.5) + 
  geom_line(aes(group = interaction(tk, app.meth, id)), size = 0.5) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste(NH[3]-N, '   flux (g  ',  min^-1, ' ', m^-2, ')'))) + 
  xlab('Time after slurry application (hours)') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-field-trials/flux', height = 4, width = 7) 

ggplot(df1, aes(elapsed.time, flux.perc, color = in1)) + 
  geom_point(size = 0.5) + 
  geom_line(aes(group = interaction(tk, app.meth, id)), size = 0.5) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste('TAN (%  ',  min^-1,')'))) + 
  xlab('Time after slurry application (hours)') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-field-trials/flux_perc', height = 4, width = 7) 

# Cum emis
ggplot(df1, aes(elapsed.time, cum.emis, color = in1)) + 
  geom_point(size = 0.5) + 
  geom_line(aes(group = interaction(tk, app.meth, id)), size = 0.5) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste('Cumulative  ', NH[3]-N, '  (g  ', m^-2, ')'))) +
  xlab('Time after digestate application (hours)') + 
  theme(legend.title = element_blank(), legend.position = 'bottom')
ggsave2x('../plots-field-trials/cum_emis', height = 4, width = 7)

ggplot(df2, aes(elapsed.time, cum.emis.mn, fill = in2, color = in2)) + 
  geom_point(size = 0.5) + 
  geom_line(aes(group = in2), size = 0.5) + 
  geom_ribbon(aes(ymin = cum.emis.mn - cum.emis.sd, ymax = cum.emis.mn + cum.emis.sd, group = in2), alpha = 0.3, color = NA) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + scale_fill_brewer(palette = 'Set1') + 
  ylab(expression(paste('Cumulative  ', NH[3]-N, '  (g  ', m^-2, ')'))) +
  xlab('Time after digestate application (hours)') + 
  theme(legend.title = element_blank(), legend.position = 'bottom')
ggsave2x('../plots-field-trials/cum_emis_mn', height = 4, width = 7)

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
  xlab('Time after slurry application (hours)') + 
  ylab(expression(paste("Temperature ( ",degree,"C) / Wind speed ( m ", s^-1, ') / Precipitation [mm]'))) +
  theme(legend.position = 'bottom', legend.title = element_blank()) + 
  ylim(0, 13)
ggsave2x('../plots-field-trials/weather', height = 4, width = 7)


# # temperature sensors
# dt$elapsed.time <- as.numeric(dt$elapsed.time)
# 
# ggplot() + 
#   geom_line(dt, aes(elapsed.time, temp, color = id)) + 
#   facet_wrap(~ tk) + 
#   theme_bw() + 
#   geom_point(data = weather, aes(elapsed.time, num))

