
# Flux
ggplot(dd, aes(elapsed.time, conc, color = treat)) + 
  geom_point() + 
  geom_line(aes(group = id)) +  
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste(NH[3], '   concentration [ppb]'))) + 
  xlab('Time after digestate application [hours]') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-AER-test/AER_test_s', height = 3, width = 4) 
ggsave2x('../plots-AER-test/AER_test_l', height = 7, width = 6)


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
