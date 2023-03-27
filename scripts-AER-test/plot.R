
dd$treat <- gsub('_', ' ', dd$treat)

# Flux
ggplot(dd, aes(elapsed.time, flux, color = treat)) + 
  geom_point(size = 0.5) + geom_line(aes(group = id), size = 0.5) +
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste(NH[3]-N, '   flux (g  ',  min^-1, ' ', m^-2, ')'))) + 
  xlab('Time after slurry application (hours)') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-AER-test/AER_test', height = 4, width = 4) 


# Recovery time 
ggplot(dr, aes(elapsed.time, NH3_raw, color = treat, shape = id)) + 
  geom_point(size = 0.5) + 
  facet_grid(~ round) + 
  theme_bw() + 
  ylim(0, 370) + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste(NH[3], '   (ppb)'))) + 
  xlab('Time after slurry application (hours)') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-AER-test/AER_test_rec', height = 4, width = 8) 
