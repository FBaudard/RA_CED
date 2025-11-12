import pandas as pd
import matplotlib as mp

path = 'c:\Users\bauda\OneDrive\Documents\5a\SQD\S1\Assistanat de recherche\RA_CED\data\ISSP_data.csv'
data = pd.read_excel(path)

print(data.head())