#### Data Access ####

# Installing Necessary Packages (note: run only if packages not installed)

install.packages("rvest")
install.packages("tidyverse")
install.packages("data.table")

# Loading Packages

library(rvest)
library(tidyverse)
library(data.table)

# Setting working directory

wd = 'C:\\Users\\rifay\\OneDrive\\Documents\\MSIS 5223\\Project\\project-team-repository-basketball-geniuses\\data_files\\'
setwd(wd)
getwd()

### Initially Gathering Advanced stats from basketball reference for 1990 to 2020 ###

# Creating empty data table to store variables

advanced_stats = data.table()

# Looping through website for advanced stats from 1990 to 2020

for(year in seq(from=1990, to=2020, by =1 )){
  
  link = paste0("https://www.basketball-reference.com/leagues/NBA_",year,"_advanced.html")
  page = read_html(link)
  
  year = year
  player = page %>% html_nodes("th+ .left a") %>% html_text()
  position = page %>% html_nodes("td.center") %>% html_text() 
  age = page %>% html_nodes(".center+ .right") %>% html_text()
  team = page %>% html_nodes("td+ .left") %>% html_text()
  games_played = page %>% html_nodes(".left+ .right") %>% html_text()
  minutes_played = page %>% html_nodes(".right:nth-child(7)") %>% html_text()
  player_efficiency_rating = page %>% html_nodes(".right:nth-child(8)") %>% html_text()
  true_shooting_percentage = page %>% html_nodes(".right:nth-child(9)") %>% html_text()
  three_point_attempt_rate = page %>% html_nodes(".right:nth-child(10)") %>% html_text()
  free_throw_attempt_rate = page %>% html_nodes(".right:nth-child(11)") %>% html_text()
  offensive_rebound_percentage = page %>% html_nodes(".right:nth-child(12)") %>% html_text()
  defensive_rebound_percentage = page %>% html_nodes(".right:nth-child(13)") %>% html_text()
  total_rebound_percentage = page %>% html_nodes(".right:nth-child(14)") %>% html_text()
  assist_percentage = page %>% html_nodes(".right:nth-child(15)") %>% html_text()
  steal_percentage = page %>% html_nodes(".right:nth-child(16)") %>% html_text()
  block_percentage = page %>% html_nodes(".right:nth-child(17)") %>% html_text()
  turnover_percentage = page %>% html_nodes(".right:nth-child(18)") %>% html_text()
  usage_percentage = page %>% html_nodes(".right:nth-child(19)") %>% html_text()
  offensive_win_shares = page %>% html_nodes(".right:nth-child(21)") %>% html_text()
  defensive_win_shares = page %>% html_nodes(".right:nth-child(22)") %>% html_text()
  win_shares = page %>% html_nodes(".right:nth-child(23)") %>% html_text()
  win_share_per_fourty_eight_minutes = page %>% html_nodes(".right:nth-child(24)") %>% html_text()
  offensive_plus_minus = page %>% html_nodes(".right:nth-child(26)") %>% html_text()
  defensive_plus_minus = page %>% html_nodes(".right:nth-child(27)") %>% html_text()
  box_plus_minus = page %>% html_nodes(".right:nth-child(28)") %>% html_text()
  value_over_replace_player = page %>% html_nodes(".right:nth-child(29)") %>% html_text()
  
  advanced_stats = rbind(advanced_stats, data.table(year, player, position, age, team, games_played, minutes_played
                                                    , player_efficiency_rating, true_shooting_percentage, three_point_attempt_rate
                                                    , free_throw_attempt_rate, offensive_rebound_percentage
                                                    , defensive_rebound_percentage, total_rebound_percentage, assist_percentage
                                                    , steal_percentage, block_percentage, turnover_percentage, usage_percentage
                                                    , offensive_win_shares, defensive_win_shares, win_shares
                                                    , win_share_per_fourty_eight_minutes, offensive_plus_minus, defensive_plus_minus
                                                    , box_plus_minus , value_over_replace_player, stringsAsFactors = FALSE))
}


# Writing obtaned advanced stats to a csv file

write.csv(advanced_stats,"data_access_advanced_stats.csv",row.names = FALSE)

### Next Gathering Basic per game stats from basketball reference for 1990 to 2020 ###

# Creating empty data table to store variables

basic_stats = data.table()

# Looping through website for basic stats from 1990 to 2020

for(year in seq(from=1990, to=2020, by =1 )){
  
  link2 = paste0("https://www.basketball-reference.com/leagues/NBA_",year,"_per_game.html")
  page2 = read_html(link2)
  
  year = year
  player = page2 %>% html_nodes("th+ .left") %>% html_text()
  position = page2 %>% html_nodes(".full_table .center") %>% html_text() 
  age = page2 %>% html_nodes(".center+ .right") %>% html_text()
  team = page2 %>% html_nodes("td+ .left") %>% html_text()
  games_played = page2 %>% html_nodes(".left+ .right") %>% html_text()
  games_started = page2 %>% html_nodes(".right:nth-child(7)") %>% html_text()
  minutes_played = page2 %>% html_nodes(".right:nth-child(8)") %>% html_text()
  field_goals_made_per_game = page2 %>% html_nodes(".right:nth-child(9)") %>% html_text()
  field_goals_attempts_per_game = page2 %>% html_nodes(".right:nth-child(10)") %>% html_text()
  field_goals_percentage_per_game = page2 %>% html_nodes(".right:nth-child(11)") %>% html_text()
  three_pointer_made_per_game = page2 %>% html_nodes(".right:nth-child(12)") %>% html_text()
  three_pointer_attempts_per_game = page2 %>% html_nodes(".right:nth-child(13)") %>% html_text()
  three_pointer_percentage_per_game = page2 %>% html_nodes(".right:nth-child(14)") %>% html_text()
  two_pointer_made_per_game = page2 %>% html_nodes(".right:nth-child(15)") %>% html_text()
  two_pointer_attempts_per_game = page2 %>% html_nodes(".right:nth-child(16)") %>% html_text()
  two_pointer_percentage_per_game = page2 %>% html_nodes(".right:nth-child(17)") %>% html_text() 
  effective_field_goal_percentage = page2 %>% html_nodes(".right:nth-child(18)") %>% html_text()
  free_throw_made_per_game = page2 %>% html_nodes(".right:nth-child(19)") %>% html_text()
  free_throw_attempts_per_game = page2 %>% html_nodes(".right:nth-child(20)") %>% html_text()
  free_throw_percentage_per_game = page2 %>% html_nodes(".right:nth-child(21)") %>% html_text()
  offensive_rebound_per_game = page2 %>% html_nodes(".right:nth-child(22)") %>% html_text()
  defensive_rebound_per_game = page2 %>% html_nodes(".right:nth-child(23)") %>% html_text()
  total_rebound_per_game = page2 %>% html_nodes(".right:nth-child(24)") %>% html_text()
  assists_per_game = page2 %>% html_nodes(".right:nth-child(25)") %>% html_text()
  steals_per_game = page2 %>% html_nodes(".right:nth-child(26)") %>% html_text()
  blocks_per_game = page2 %>% html_nodes(".right:nth-child(27)") %>% html_text()
  turnovers_per_game = page2 %>% html_nodes(".right:nth-child(28)") %>% html_text()
  fouls_per_game = page2 %>% html_nodes(".right:nth-child(29)") %>% html_text()
  points_per_game = page2 %>% html_nodes(".right:nth-child(30)") %>% html_text()
   
  basic_stats = rbind(basic_stats, data.table(year, player, position, age, team, games_played, 
                                              games_started, minutes_played, field_goals_made_per_game, 
                                              field_goals_attempts_per_game, field_goals_percentage_per_game,
                                              three_pointer_made_per_game, three_pointer_attempts_per_game,
                                              three_pointer_percentage_per_game, two_pointer_made_per_game,
                                              two_pointer_attempts_per_game, two_pointer_percentage_per_game, 
                                              effective_field_goal_percentage, free_throw_made_per_game,
                                              free_throw_attempts_per_game, free_throw_percentage_per_game,
                                              offensive_rebound_per_game, defensive_rebound_per_game, 
                                              total_rebound_per_game, assists_per_game, 
                                              steals_per_game, blocks_per_game, turnovers_per_game, 
                                              fouls_per_game, points_per_game, stringsAsFactors = FALSE))
}

# Writing obtaned basic stats to a csv file

write.csv(basic_stats,"data_access_basic_stats.csv",row.names = FALSE)
