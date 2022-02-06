#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import numpy as np
import pandas as pd
from sklearn import preprocessing
from sklearn.preprocessing import StandardScaler
import matplotlib.pyplot as plt
import seaborn
from sklearn.decomposition import PCA as pca
from sklearn.decomposition import FactorAnalysis as fact
from factor_analyzer import FactorAnalyzer
import random

### Data Reduction ###

# Build a correlation heatmap on the new data -> Pearson correlation -> 1 is total positive linear correlation ->
# 0 is no correlation -> -1 is total negative linear correlation
correlation = basketball_2.corr()
#print(correlation)

plt.figure(figsize = (12,11))
seaborn.heatmap(correlation, annot=True, cmap='coolwarm')
plt.show()

random.seed(12345)

shuffled = basketball_2.sample(frac=1)
result = np.array_split(shuffled, 2)
pca_df = result[0]
fa_df = result[1]
# PCA Analysis
basketball_pca = pca(n_components=28).fit(pca_df)

# Eigenvalues -> Greater or Equal to 1 is considered influential
eigenvalues = basketball_pca.explained_variance_
print(eigenvalues)
x = list(range(1, len(eigenvalues)))
y = list(range(1, len(eigenvalues)+1))

plt.figure(figsize=(7, 5))
plt.plot(y, basketball_pca.explained_variance_, '-o')
plt.title('PCA Eigenvalues')
plt.ylabel('Proportion of Variance Explained')
plt.xlabel('Principal Component')
plt.xlim(0.75, 4.25)
plt.ylim(0, max(eigenvalues) + 100)
plt.xticks(x)
plt.show()

# Factor Analysis
#basketball_factor = basketball_2
fa = FactorAnalyzer(4, rotation='varimax')
fa.fit(fa_df)
factors = fa.loadings_
print('Factors')
for i in range(0,len(factors)):
    print(basketball_2.columns[i] + ' ' + str(factors[i]))

final_data = basketball_2.copy()

final_data = final_data.drop(columns=['age', 'defensive_plus_minus', 'games_started', 'offensive_rebound_per_game',
                                      'blocks_per_game', 'fouls_per_game', 'minutes_played'])



final_data['win_shares'] = df['win_shares']

final_data.to_csv(r'C:\Users\laggi\Desktop\DATA\final_data.csv', index = False)

