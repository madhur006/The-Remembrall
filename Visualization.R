# 2 or 3 line plot by year eg rate1, rate2 - All these rates are in different columns.
# so first we have to create a long form table 

df_longer <- df %>% 
  select(yr, rate1, rate2, rate3) %>% 
  pivot_longer(
    cols = c( rate1, rate2), 
    names_to = 'metric type', 
    values_to = 'values'
  )

### visualization lineplot with multiple trendlines 
p <- df_longer %>%
  ggplot(aes(x = yr, y = values, color = `metric type`)) +
  geom_line(linewidth = 1.3) +
  geom_point(size = 3) +
  expand_limits(y = 0) +         # y axis from 0 
  scale_color_manual(
    values = c("rate1" = "#0072B2", "rate2" = "#D55E00"), # Specific colors 
    labels = c("rate1" = "rate 1", "rate2" = "rate 2") # Custom labels 
  ) +
  # geom_vline(xintercept = 2024.05, linetype = "dashed", color = "gray50") +             # add vertical line 
  geom_text(aes(label = scales::label_percent(accuracy = 0.1)(values)),                   # add labels percent - values is the column with the values 
            vjust = -1.5,                                                                # adjust for the label (when overlap try to change this value)
            size = 5,                                                                    # Increase data label font size
            show.legend = FALSE) +
  coord_cartesian(ylim = c(0, max(table_offer_4_longer$values) * 1.15)) +                 # so the y axis from top doesnt cut-off
  scale_y_continuous(labels = scales::label_percent()) +                                  # y axis as percent
  scale_x_continuous(                                                                      # x axis continuous - break or show all years 
    breaks = unique(df_longer$yr),
    labels = scales::label_number(accuracy = 1, big.mark = "")                           # labels using scales here 
  ) +
  labs(
    title = "Trend of rates",
    x = "Year",
    y = "rate",
    color = "rate"          # interesting - what is this? 
  ) +
  theme_classic(base_size = 13) +                                                       # Increase base font size for all text elements
  theme(       
    plot.title = element_text(size = 15, face = "bold", hjust = 0.5), #  adjustments for title
    axis.title.x = element_text(size = 13, face = "bold"), # Increased size and made bold
    axis.title.y = element_text(size = 13, face = "bold"), # Increased size and made bold
    axis.text.x = element_text(size = 13), # Increased tick label size
    axis.text.y = element_text(size = 13), # Increased tick label size
    legend.title = element_text(size = 13, face = "bold"),
    legend.text = element_text(size = 13),
    plot.margin = unit(c(1.5, 1.5, 1.5, 1.5), "cm")                                     # Increased left, right, top, bottom margin to 1.5 cm

)

ggsave("plot1.png", 
       plot = p, device = "png", width = 10, height = 8, units = "in")


# p2 
p2 <- ggplot(df_trend, aes(x = year, y = count)) +
  geom_line() +
  scale_x_continuous(breaks = pretty_breaks(n = 11)) +
  #  scale_x_continuous(breaks = seq(min(df_trend$year), max(df_trend$year))) +
  scale_y_continuous(breaks = pretty_breaks(n = 10)) +
  labs(
    title = 'Annual number',
    x = 'Year',
    y = 'Count'
  ) +
  geom_vline(xintercept = 2015, linetype = "dashed", color = "blue", linewidth = 0.7) +
  # Add text label 
  annotate("text", 
           x = 2015.2, 
           y = max(df_trend$count, na.rm = TRUE) * 0.5,  # adjust as needed
           label = "Feb 1, 2015  \ntype 2 diabetes \ncontraindication codified",
           hjust = 1.1, vjust = 0, angle = 0,
           size = 3.5, color = "blue") + 
  geom_vline(xintercept = 2022, linetype = "dashed", color = "red", linewidth = 0.7) +
  # Add text label 
  annotate("text", 
           x = 2022, 
           y = max(df_trend$count, na.rm = TRUE) * 0.3,  # adjust as needed
           label = "July 26, 2022 \ntype 2 diabetes \ncontraindication removed",
           hjust = 1.1, vjust = -1.9, angle = 0,
           size = 3.5, color = "red") +
  theme_classic() 





# scales library - here for number 
  geom_text(aes(label = scales::label_number(accuracy = 0.01)(values)),
            vjust = -1.5,
            size = 3, # Increased data label font size
            show.legend = FALSE) 

# scales library - percent
  geom_text(aes(label = scales::label_percent(accuracy = 0.1)(values)),                   
            vjust = -1.5,                                                                
            size = 5,                                                                    
            show.legend = FALSE)

scale_y_continuous(labels = scales::label_percent()) +                                  
scale_x_continuous(                                                                    
    breaks = unique(df_longer$yr),
    labels = scales::label_number(accuracy = 1, big.mark = "")    
