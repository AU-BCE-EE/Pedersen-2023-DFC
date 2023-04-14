
dd$in1 <- paste(dd$trial, dd$app)

dd$in1_f = factor(dd$in1, levels = c('A Trailing hose', 'B Trailing hose', 'C Trailing hose', 'C Injection'))

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


# conference poster plot
dd$trialA <- dd$trial
dd$trialA <- mapvalues(dd$trialA, from = 'A', to = 'A: Manual')
dd$trialA <- mapvalues(dd$trialA, from = 'B', to = 'B: 30-m boom')
dd$trialA <- mapvalues(dd$trialA, from = 'C', to = 'C: 3-m boom')

dd$appA <- dd$app
dd$appA <- mapvalues(dd$appA, from = 'Trailing hose', to = 'TH')
dd$appA <- mapvalues(dd$appA, from = 'Injection', to = 'IN')

dd$in1A <- factor(interaction(dd$trialA, dd$appA))
dd$in1A <- gsub('\\.', ' ', dd$in1A)

ggplot(dd, aes(Ns, value, color = LSDno)) + 
  geom_point() + 
  geom_line(aes(group = interaction(trial, app, LSDno)), size = 0.5) + 
  facet_wrap(~ in1A, ncol = 4) + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab('Diff. in emission (% TAN)') +
  xlab('Number of replicates') + 
  theme(legend.position = 'bottom', legend.title = element_blank()) + 
  ylim(0, NA)
ggsave2x('../plots-LSD/LSD-fixedY_EGU', height = 3, width = 4.7) 


