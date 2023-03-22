
dd$treat <- gsub('_', ' ', dd$treat)

# Flux
ggplot(dd, aes(elapsed.time, flux, color = treat)) + 
  geom_point(shape = 1) + geom_line(aes(group = id)) +
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste(NH[3]-N, '   flux (g  ',  min^-1, ' ', m^-2, ')'))) + 
  xlab('Time after slurry application (hours)') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-AER-test/AER_test_s', height = 3, width = 4) 
ggsave2x('../plots-AER-test/AER_test_l', height = 7, width = 6)


# Recovery time 
ggplot(dr, aes(elapsed.time, NH3_raw, color = treat, shape = id)) + 
  geom_point() + 
  facet_grid(~ round) + 
  theme_bw() + 
  ylim(0, 370) + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste(NH[3], '   (ppb)'))) + 
  xlab('Time after slurry application (hours)') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-AER-test/AER_test_rec_s', height = 3, width = 8) 
