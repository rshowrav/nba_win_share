# Deliverable 2 Visualizations 

# Imports
library(ggplot2)
library(grid)
library(dplyr)
library(RColorBrewer)

# Working Directory
wd = '/Users/kaelanhackenburg/Desktop/Twitter-Scripts-Basketball-Genuises/'
setwd(wd)

# Read Data
basketball <- read.csv('final_basketball.csv', header = TRUE)
secondary <- read.csv('final_data.csv', header = TRUE)

# Read in Colors DataFrame
d = data.frame(c=colors(), y=seq(0,length(colors())-1)%%66, x=seq(0, length(colors())-1)%/%66)

# Build a Standard Line Graph to start
# Change the title and axis as needed
range(basketball$defensive_rebound_per_game) # Highest is 11.4

first_line <- ggplot(basketball, aes(y = defensive_rebound_per_game, x = win_shares)) +
  scale_y_continuous(limits = c(0, 12)) +
  labs(y = 'Defensive Rebounds Per Game', x = 'Win Shares', title = 'Analysis of Defensive Rebounds Per Game and Win Shares') +
  theme(
    axis.title = element_text(size = 12, family = 'Georgia', color = 'white'),
    axis.text.x = element_text(size = 10, family = 'Arial', color = 'white'),
    axis.text.y = element_text(size = 10, family = 'Arial', color = 'white'),
    plot.background = element_rect(fill = 'black'),
  ) +
  geom_line(color = 'black')
plot(first_line)


# Line chart for assists per game
range(basketball$assists_per_game) # Highest is 12.8

assist_line <- ggplot(basketball, aes(y = assists_per_game, x = offensive_plus_minus)) +
  scale_y_continuous(limits = c(0,14)) +
  labs(y = 'Assists Per Game', x = 'Offensive Plus Minus', title = 'The Effect of Assists per Game on 
       Offensive Plus Minus') +
  theme(
    axis.title = element_text(size = 12, family = 'Georgia', color = 'white'),
    axis.text.x = element_text(size = 10, family = 'Arial', color = 'white'),
    axis.text.y = element_text(size = 10, family = 'Arial', color = 'white'),
    plot.background = element_rect(fill = 'black'),
    panel.background = element_rect(fill = 'black'),
  ) + 
  geom_line(color = 'green')
plot(assist_line)

# Find the Average Assists Per Game and add an indicator line
mean(basketball$assists_per_game) # Average (mean) is 1.9

avg_assists <- assist_line + geom_hline(yintercept = 1.9, col = 'red')
plot(avg_assists)

# Arrow to Bring Attention to the line
assist_arrow <- avg_assists +
  annotate('segment', x = -15.0, xend = -16.0, y = 3.0, yend = 2.0,
           color = 'red', size = 1.5, arrow = arrow())
plot(assist_arrow)

assists_annotation <- assist_arrow +
  annotate('text', x = -13, y = 2.9, color = 'red',
           label = glue::glue('Average Assists 
                              Per Game'))
plot(assists_annotation)

# Attempt to find the Average Win Shares for each position, possibly indicating 
# the most valuable position for a given NBA Team.
pg_ws <- basketball %>%
  select(win_shares, position_PG) %>%
  filter(position_PG == 1)

average_PG_ws <- mean(pg_ws$win_shares)

sg_ws <- basketball %>%
  select(win_shares, position_SG) %>%
  filter(position_SG == 1)

average_SG_ws <- mean(sg_ws$win_shares)

sf_ws <- basketball %>%
  select(win_shares, position_SF) %>%
  filter(position_SF == 1)

average_SF_ws <- mean(sf_ws$win_shares)

pf_ws <- basketball %>%
  select(win_shares, position_PF) %>%
  filter(position_PF == 1)

average_PF_ws <- mean(pf_ws$win_shares)

c_ws <- secondary %>%
  select(win_shares, position_C) %>%
  filter(position_C == 1)

average_C_ws <- mean(c_ws$win_shares)

average_ws_df <- data.frame(average_PG_ws, average_SG_ws, average_SF_ws, average_PF_ws, average_C_ws)

# Create a bar plot to show the average amount of win shares by position
ws_stats <- c(2.489757, 2.290314, 2.563207, 2.703864, 2.473247)
position <- c('PG', 'SG', 'SF', 'PF', 'C')



ws_bar <- barplot(height = ws_stats, names = position, xlab = 'Position', ylab = 'Win Shares',
        main = 'Average Win Shares by Position', ylim = c(0,5), border = 'black',
        col = brewer.pal(4, name = 'Spectral'))