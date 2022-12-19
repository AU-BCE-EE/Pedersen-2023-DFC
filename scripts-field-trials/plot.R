
df1$app.meth <- mapvalues(df1$app.meth, from = 'TH', to = 'Trailing hose')
df2$app.meth <- mapvalues(df2$app.meth, from = 'TH', to = 'Trailing hose')
df1$app.meth <- mapvalues(df1$app.meth, from = 'IN', to = 'Injection')
df2$app.meth <- mapvalues(df2$app.meth, from = 'IN', to = 'Injection')

in1 <- factor(interaction(df1$app.meth, df1$meas.meth))
in2 <- factor(interaction(df2$app.meth, df2$meas.meth))

# Flux
ggplot(df1, aes(elapsed.time, flux, color = in1)) + 
  geom_point() + 
  geom_line(aes(group = interaction(tk, app.meth, id))) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste(NH[3]-N, '   flux [g  ',  min^-1, ' ', m^-2, ']'))) + 
  xlab('Time after slurry application [hours]') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-field-trials/flux_s', height = 3, width = 7) 
ggsave2x('../plots-field-trials/flux_l', height = 7, width = 10)

ggplot(df2, aes(elapsed.time, flux.mn, color = in2, fill = in2)) + 
  geom_point() +
  geom_line(aes(group = in2)) + 
  geom_ribbon(aes(ymin = flux.mn - flux.sd, ymax = flux.mn + flux.sd, group = in2), alpha = 0.3, color = NA) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + scale_fill_brewer(palette = 'Set1') +
  ylab(expression(paste(NH[3]-N, '   flux [g  ',  min^-1, ' ', m^-2, ']'))) + 
  xlab('Time after slurry application [hours]') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-field-trials/flux_mn_s', height = 3, width = 7)
ggsave2x('../plots-field-trials/flux_mn_l', height = 7, width = 10)


# Cum emis
ggplot(df1, aes(elapsed.time, cum.emis, color = in1)) + 
  geom_point() + 
  geom_line(aes(group = interaction(tk, app.meth, id))) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste('Cumulative  ', NH[3]-N, '  [g  ', m^-2, ']'))) +
  xlab('Time after digestate application [hours]') + 
  theme(legend.title = element_blank(), legend.position = 'bottom')
ggsave2x('../plots-field-trials/cum_emis_s', height = 3, width = 7)
ggsave2x('../plots-field-trials/cum_emis_l', height = 7, width = 10)

ggplot(df2, aes(elapsed.time, cum.emis.mn, fill = in2, color = in2)) + 
  geom_point() + 
  geom_line(aes(group = in2)) + 
  geom_ribbon(aes(ymin = cum.emis.mn - cum.emis.sd, ymax = cum.emis.mn + cum.emis.sd, group = in2), alpha = 0.3, color = NA) + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + scale_fill_brewer(palette = 'Set1') + 
  ylab(expression(paste('Cumulative  ', NH[3]-N, '  [g  ', m^-2, ']'))) +
  xlab('Time after digestate application [hours]') + 
  theme(legend.title = element_blank(), legend.position = 'bottom')
ggsave2x('../plots-field-trials/cum_emis_mn_s', height = 3, width = 7)
ggsave2x('../plots-field-trials/cum_emis_mn_l', height = 7, width = 10)


# Weather 
weather$what <- mapvalues(weather$what, from = 'airT', to = 'Temperature')
weather$what <- mapvalues(weather$what, from = 'WS', to = 'Wind speed')
weather <- weather[weather$elapsed.time <= 120, ]

ggplot(na.omit(weather), aes(elapsed.time, num, color = what)) + 
  geom_line() + 
  facet_wrap(~ tk, scale = 'free') + 
  theme_bw() + 
  xlab('Time after slurry application [hours]') + 
  ylab(expression(paste("Temperature [ ",degree,"C] / Wind speed [ m ", s^-1, ']'))) +
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-field-trials/weather', height = 3, width = 7)


# temperature sensors
ggplot(dt, aes(elapsed.time, temp, color = id)) + 
  geom_line() + 
  geom_line(weather[weather$what == 'Temperature'], aes(elapsed.time, num)) +
  facet_wrap(~ tk) + 
  theme_bw()



