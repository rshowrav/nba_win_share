#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
import fnmatch

### Data Transformation ### 


pd.set_option('display.max_columns', None)

#read in the data
data = pd.read_csv(r'C:\Users\laggi\Desktop\DATA\data_cleaning_transformation_part_1.csv', sep=",")
df = data.copy()
cols = df.columns

# choose what key words we want to filter by and drop from the df
filtered_rate = fnmatch.filter(cols, '*rate')
filtered_percent = fnmatch.filter(cols, '*percent*')
filtered = filtered_rate + filtered_percent
df.drop(filtered, inplace=True, axis=1)

# Make a new column for a starter ie started more than half the games(42)
def starter(row):
    if row['games_played'] > 42:
        val = 1
    else:
        val = 0
    return val

#apply on a row by row basis
df['starter'] = df.apply(starter ,axis=1)


# Log Transforms
norm_cols = ['field_goals_attempts_per_game', 'field_goals_made_per_game', 'three_pointer_made_per_game',
       'three_pointer_attempts_per_game', 'two_pointer_made_per_game',
       'two_pointer_attempts_per_game', 'free_throw_made_per_game',
       'free_throw_attempts_per_game', 'value_over_replace_player', 'minutes_played']
df[norm_cols] = StandardScaler().fit_transform(df[norm_cols])

df.to_csv(r'C:\Users\laggi\Desktop\DATA\data_transformation_combined_stats.csv', index = False)

