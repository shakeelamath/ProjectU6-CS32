#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
import Recommenders as Recommenders


# In[2]:


song_df_1 = pd.read_csv('triplets_file.csv')
song_df_1.head()


# In[3]:


song_df_2 = pd.read_csv('song_data.csv')
song_df_2.head()


# In[4]:


# combine both data
song_df = pd.merge(song_df_1, song_df_2.drop_duplicates(['song_id']), on='song_id', how='left')
song_df.head()


# In[5]:


print(len(song_df_1), len(song_df_2))


# In[6]:


len(song_df)


# In[7]:


# creating new feature combining title and artist name
song_df['song'] = song_df['title']+' - '+song_df['artist_name']
song_df.head()


# In[8]:


# taking top 10k samples for quick results
song_df = song_df.head(10000)


# In[9]:


# cummulative sum of listen count of the songs
song_grouped = song_df.groupby(['song']).agg({'listen_count':'count'}).reset_index()
song_grouped.head()


# In[10]:


grouped_sum = song_grouped['listen_count'].sum()
song_grouped['percentage'] = (song_grouped['listen_count'] / grouped_sum ) * 100
song_grouped.sort_values(['listen_count', 'song'], ascending=[0,1])


# In[11]:


pr = Recommenders.popularity_recommender_py() 


# In[12]:


pr.create(song_df, 'user_id', 'song')


# In[13]:


# display the top 10 popular songs
pr.recommend(song_df['user_id'][5])


# In[14]:


pr.recommend(song_df['user_id'][100])


# In[15]:


ir = Recommenders.item_similarity_recommender_py()
ir.create(song_df, 'user_id', 'song')


# In[16]:


user_items = ir.get_user_items(song_df['user_id'][5])


# In[17]:


# display user songs history
for user_item in user_items:
    print(user_item)


# In[18]:


# give song recommendation for that user
ir.recommend(song_df['user_id'][5])


# In[19]:


# give related songs based on the words
ir.get_similar_items(['Oliver James - Fleet Foxes', 'The End - Pearl Jam'])


# In[ ]:




