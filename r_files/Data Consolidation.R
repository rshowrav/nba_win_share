#### Data Consolidation ####

# Installing Necessary Packages (note: run only if packages not installed)

install.packages("sqldf")

# Loading Packages

library(sqldf)


# Setting working directory

wd = 'C:\\Users\\rifay\\OneDrive\\Documents\\MSIS 5223\\Project\\project-team-repository-basketball-geniuses\\data_files\\'
setwd(wd)
getwd()


# Loading Data sets from data access step

advanced_stats_data = read.csv("data_access_advanced_stats.csv")
basic_stats_data = read.csv("data_access_basic_stats.csv")

# Using SQLdf to update player name column in basic_stats_data
# THis column has certain player with astericks (*) in there name

advanced_stats_data_new = sqldf("SELECT *, REPLACE(player, '*', '') as new_player_name from advanced_stats_data")


### For data consildation of the above datasets sql package will be used in R
### A inner join will be used on above dataset on year, player name, age, and team played on
### Note limiting records where players played 10 games
### Note join used will not match records that may have data quality issues
### Also removing duplicate records that may skew the data

combined_stats_data = sqldf("SELECT DISTINCT a.year
, a.player
, a.position
, a.age
, a.team
, a.games_played
, a.minutes_played
, a.player_efficiency_rating
, a.true_shooting_percentage
, a.three_point_attempt_rate
, a.free_throw_attempt_rate
, a.offensive_rebound_percentage
, a.defensive_rebound_percentage
, a.total_rebound_percentage
, a.assist_percentage
, a.steal_percentage
, a.block_percentage
, a.turnover_percentage
, a.usage_percentage
, a.offensive_win_shares
, a.defensive_win_shares
, a.win_shares
, a.win_share_per_fourty_eight_minutes
, a.offensive_plus_minus
, a.defensive_plus_minus
, a.box_plus_minus
, a.value_over_replace_player
, b.games_started
, b.minutes_played
, b.field_goals_made_per_game
, b.field_goals_attempts_per_game
, b.field_goals_percentage_per_game
, b.three_pointer_made_per_game
, b.three_pointer_attempts_per_game
, b.three_pointer_percentage_per_game
, b.two_pointer_made_per_game
, b.two_pointer_attempts_per_game
, b.two_pointer_percentage_per_game
, b.effective_field_goal_percentage
, b.free_throw_made_per_game
, b.free_throw_attempts_per_game
, b.free_throw_percentage_per_game
, b.offensive_rebound_per_game
, b.defensive_rebound_per_game
, b.total_rebound_per_game
, b.assists_per_game
, b.steals_per_game
, b.blocks_per_game
, b.turnovers_per_game
, b.fouls_per_game
, b.points_per_game
FROM advanced_stats_data a
JOIN basic_stats_data b on a.year = b.year and a.player=b.player and a.team=b.team and a.age=b.age")

# Writing dataset to csv

write.csv(combined_stats_data,"data_consolidation_combined_stats.csv",row.names = FALSE)
