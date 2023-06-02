

ggplot(dd, aes(Mean, Variance, color = Treat)) + 
  geom_point() + 
  geom_line(aes(group = Treat), size = 0.5) + 
  theme_bw() + 
  scale_color_brewer(palette = 'Set1') + 
  ylab('Variance') +
  xlab(expression(paste('Mean TAN (%  ',  min^-1,')'))) + 
  theme(legend.position = 'bottom', legend.title = element_blank())
ggsave2x('../plots-variance/Variance', height = 3, width = 3) 
