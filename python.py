# column names which contain 'ctr' 
columns_with_ctr = [
    col for col in df.columns
    if 'ctr' in col.lower()
]

# use numpy to create new column based on conditions 
df['linkage'] = np.where(df['prob'] >= 0.8, 'match', 'nonmatch')

# return the rows where the stages are maximum eg 5 
df_max_rows = df.loc[df.groupby("cluster_id")["stage"].idxmax()]

# get the minimum date in each cluster and then convert it into an dataframe by using reset_index
df_min_date = df.groupby('cluster_id')['registerationDate'].min().reset_index()

# Excel file - multiple sheets
excel_file_name = 'myfile.xlsx'
writer = pd.ExcelWriter(excel_file_name, engine='xlsxwriter')
df1.to_excel(writer, sheet_name='sheet_one', index=False)
df2.to_excel(writer, sheet_name='sheet_two', index=False)
writer.close()  # important to save file 

# filter columns whose name contains ctr
columns_with_ctr = df.filter(regex='(?i)ctr', axis=1).columns.tolist()

# convert float column to str (eg Id column)
nkr['col'] = df['col'].astype(int) # convert 234.0 to 234 
nkr['col'] = df['col'].astype(str) # convert 234 to str
