
dd$in1 <- paste(dd$trial, dd$app)

dd$in1_f = factor(dd$in1, levels = c('A Trailing hose', 'B Trailing hose', 'C Trailing hose', 'C Injection'))

# Flux - free y_axis
ggplot(dd, aes(Ns, value, color = LSDno)) + 
  geom_point() + 
  geom_line(aes(group = interaction(trial, app, LSDno)), size = 0.5) + 
  facet_wrap(~ in1_f, scale = 'free', ncol = 4) + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste('Difference in  ', NH[3]-N, '  emission (% TAN)'))) +
  xlab('Number of replicates') + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-LSD/LSD_freeY', height = 4, width = 7) 


# Flux - fixed y_axis
ggplot(dd, aes(Ns, value, color = LSDno)) + 
  geom_point() + 
  geom_line(aes(group = interaction(trial, app, LSDno)), size = 0.5) + 
  facet_wrap(~ in1_f, ncol = 4) + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab(expression(paste('Difference in  ', NH[3]-N, '  emission (% TAN)'))) +
  xlab('Number of replicates') + 
  theme(legend.position = 'bottom', legend.title = element_blank()) + 
  ylim(0, NA)
ggsave2x('../plots-LSD/LSD-fixedY', height = 4, width = 7) 
