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

# count of rows (or unique IDs) belonging to each cluster_id
df['cluster_size'] = df.groupby('cluster_id')['unique_id'].transform('size')

# sort by 2 columns 
df.sort_values(by=['col1', 'col2'], ascending=[False, False])

# convert scientific notation to readable 
df['match_probability'] = df['match_probability'].map('{:.2f}'.format)

# check if clusters have df_2 (since we know df_2 all records are unique) more than once in cluster
df_2only = df_cluster[df_cluster['source_dataset'] == 'df_2']    # seperate the df2 rows
df_2only_count = df_2only.groupby('cluster_id')['unique_id'].nunique().reset_index(name='df_2only_count') # count number of uniqueids in a cluster, reset index - put them in df
red_flag_clusters = df_2only_count[df_2only_count['df_2only_count'] > 1]  # clusters with more than 1 df2
len(red_flag_clusters)


