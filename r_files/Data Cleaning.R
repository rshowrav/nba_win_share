### Data Cleaning####

# Installing library packages if needed

install.packages("dummies")
install.packages("car")
install.packages("psych")

# Importing libraries

library(dummies)
library(car)
library(psych)

# Setting working directory
wd = 'C:\\Users\\rifay\\OneDrive\\Documents\\MSIS 5223\\Project\\project-team-repository-basketball-geniuses\\data_files'
setwd(wd)
getwd()


# Loading Dataset
df = read.csv('data_consolidation_combined_stats.csv')

# Getting datatypes of variables
str(df)


# Getting summary statistics for variable games played
summary(df$games_played)

# Creating df2 and df3 removing games played with error results and removing games played less than 10 
# these variables tend to have missing records or could potentially skew the data
df2 = df[-grep("if", df$games_played),]
df3 = df2[df2$games_played != "1" & df2$games_played != "2" & df2$games_played != "3" & df2$games_played != "4" & df2$games_played != "5" & df2$games_played != "6" & df2$games_played != "7" & df2$games_played != "8" & df2$games_played != "9",]

# Converting games played to a numeric variable type
as.numeric(df3$games_played)

# Wrting df3 to a csv and reloading data

write.csv(df3, "data_cleaning_test_1.csv", row.names = FALSE)
df4 = read.csv('data_cleaning_test_1.csv')


# Getting data types of new dataframe

str(df4)

# Removing from df4 where TOT (player totals) is in team

df4 = df4[df4$team != "TOT",]

# Creating dummy variables for the variable position

position_dummy = dummy(df4$position, sep = '_')
colnames(position_dummy)
position_dummy = as.data.frame(position_dummy)
df4 = data.frame(df4,position_dummy)



# Creating conference variable so that team variable can be reduced to binary variable type

df4['conference'] = recode(df4$team, "'ORL'='EAST'
;'DET'='EAST'
;'WSB'='EAST'
;'MIL'='EAST'
;'CHH'='EAST'
;'PHI'='EAST'
;'CHI'='EAST'
;'BOS'='EAST'
;'ATL'='EAST'
;'CLE'='EAST'
;'NJN'='EAST'
;'NYK'='EAST'
;'MIA'='EAST'
;'IND'='EAST'
;'TOR'='EAST'
;'WAS'='EAST'
;'CHA'='EAST'
;'BRK'='EAST'
;'CHO'='EAST'
;'DEN'='WEST'
;'SAC'='WEST'
;'DAL'='WEST'
;'SAS'='WEST'
;'UTA'='WEST'
;'LAC'='WEST'
;'SEA'='WEST'
;'PHO'='WEST'
;'GSW'='WEST'
;'HOU'='WEST'
;'MIN'='WEST'
;'POR'='WEST'
;'LAL'='WEST'
;'VAN'='WEST'
;'MEM'='WEST'
;'NOH'='WEST'
;'NOK'='WEST'
;'OKC'='WEST'
;'NOP'='WEST'")

# Validating new variable conference

str(df4$conference)

# Creating dummy variables for variable conference
conference_dummy = dummy(df4$conference, sep = '_')
colnames(conference_dummy)
conference_dummy = as.data.frame(conference_dummy)
df4 = data.frame(df4,conference_dummy)


# Creating new dataframe dropping the variable conference, team, and postion since dummy variables have been created

df5 = subset(df4, select=-c(position, conference, team))


# Evaluating which variables have NA's 

summary(df5)

# Replacing NA values with 0's

df5[is.na(df5)] = 0

# Validating no more NA values in dataframe 

sum(is.na(df5))

# Evaluating outliers

boxplot(df5$year ,main = "Boxplot year")
boxplot(df5$age ,main = "Boxplot age")
boxplot(df5$games_played ,main = "Boxplot games_played")
boxplot(df5$minutes_played ,main = "Boxplot minutes_played")
boxplot(df5$player_efficiency_rating ,main = "Boxplot player_efficiency_rating")
boxplot(df5$true_shooting_percentage ,main = "Boxplot true_shooting_percentage")
boxplot(df5$three_point_attempt_rate ,main = "Boxplot three_point_attempt_rate")
boxplot(df5$free_throw_attempt_rate ,main = "Boxplot free_throw_attempt_rate")
boxplot(df5$offensive_rebound_percentage ,main = "Boxplot offensive_rebound_percentage")
boxplot(df5$defensive_rebound_percentage ,main = "Boxplot defensive_rebound_percentage")
boxplot(df5$total_rebound_percentage ,main = "Boxplot total_rebound_percentage")
boxplot(df5$assist_percentage ,main = "Boxplot assist_percentage")
boxplot(df5$steal_percentage ,main = "Boxplot steal_percentage")
boxplot(df5$block_percentage ,main = "Boxplot block_percentage")
boxplot(df5$turnover_percentage ,main = "Boxplot turnover_percentage")
boxplot(df5$usage_percentage ,main = "Boxplot usage_percentage")
boxplot(df5$offensive_win_shares ,main = "Boxplot offensive_win_shares")
boxplot(df5$defensive_win_shares ,main = "Boxplot defensive_win_shares")
boxplot(df5$win_shares ,main = "Boxplot win_shares")
boxplot(df5$win_share_per_fourty_eight_minutes ,main = "Boxplot win_share_per_fourty_eight_minutes")
boxplot(df5$offensive_plus_minus ,main = "Boxplot offensive_plus_minus")
boxplot(df5$defensive_plus_minus ,main = "Boxplot defensive_plus_minus")
boxplot(df5$box_plus_minus ,main = "Boxplot box_plus_minus")
boxplot(df5$value_over_replace_player ,main = "Boxplot value_over_replace_player")
boxplot(df5$games_started ,main = "Boxplot games_started")
boxplot(df5$minutes_played..29 ,main = "Boxplot minutes_played..29")
boxplot(df5$field_goals_made_per_game ,main = "Boxplot field_goals_made_per_game")
boxplot(df5$field_goals_attempts_per_game ,main = "Boxplot field_goals_attempts_per_game")
boxplot(df5$field_goals_percentage_per_game ,main = "Boxplot field_goals_percentage_per_game")
boxplot(df5$three_pointer_made_per_game ,main = "Boxplot three_pointer_made_per_game")
boxplot(df5$three_pointer_attempts_per_game ,main = "Boxplot three_pointer_attempts_per_game")
boxplot(df5$three_pointer_percentage_per_game ,main = "Boxplot three_pointer_percentage_per_game")
boxplot(df5$two_pointer_made_per_game ,main = "Boxplot two_pointer_made_per_game")
boxplot(df5$two_pointer_attempts_per_game ,main = "Boxplot two_pointer_attempts_per_game")
boxplot(df5$two_pointer_percentage_per_game ,main = "Boxplot two_pointer_percentage_per_game")
boxplot(df5$effective_field_goal_percentage ,main = "Boxplot effective_field_goal_percentage")
boxplot(df5$free_throw_made_per_game ,main = "Boxplot free_throw_made_per_game")
boxplot(df5$free_throw_attempts_per_game ,main = "Boxplot free_throw_attempts_per_game")
boxplot(df5$free_throw_percentage_per_game ,main = "Boxplot free_throw_percentage_per_game")
boxplot(df5$offensive_rebound_per_game ,main = "Boxplot offensive_rebound_per_game")
boxplot(df5$defensive_rebound_per_game ,main = "Boxplot defensive_rebound_per_game")
boxplot(df5$total_rebound_per_game ,main = "Boxplot total_rebound_per_game")
boxplot(df5$assists_per_game ,main = "Boxplot assists_per_game")
boxplot(df5$steals_per_game ,main = "Boxplot steals_per_game")
boxplot(df5$blocks_per_game ,main = "Boxplot blocks_per_game")
boxplot(df5$turnovers_per_game ,main = "Boxplot turnovers_per_game")
boxplot(df5$fouls_per_game ,main = "Boxplot fouls_per_game")
boxplot(df5$points_per_game ,main = "Boxplot points_per_game")
boxplot(df5$position_C ,main = "Boxplot position_C")
boxplot(df5$position_PF ,main = "Boxplot position_PF")
boxplot(df5$position_PG ,main = "Boxplot position_PG")
boxplot(df5$position_SF ,main = "Boxplot position_SF")
boxplot(df5$position_SG ,main = "Boxplot position_SG")
boxplot(df5$conference_EAST ,main = "Boxplot conference_EAST")
boxplot(df5$conference_WEST ,main = "Boxplot conference_WEST")


# Writing data frame to csv to continue data transformation in python

write.csv(df5, "data_cleaning_combined_stats.csv", row.names = FALSE)




