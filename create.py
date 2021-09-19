import glob
import pandas as pd

# Make list of all html files
#htmlfiles = []
#for file in glob.glob("*.html"):
#    htmlfiles.append(file)

# Make list of all ipynb files
ipynbfiles = []
for file in glob.glob("*.ipynb"):
    ipynbfiles.append(file)

# Create dataframes
#df1 = pd.DataFrame(htmlfiles, columns=["html"])
df = pd.DataFrame(ipynbfiles, columns=["ipynb"])

# Combine frames
#df = pd.concat([df1, df2], axis=1)

# Create new column with name of file
df['name'] = df['ipynb'].str.replace(".ipynb", "", case=False, regex=False)

# Sort
df = df.sort_values('name', ascending=True)

# Write csv
df.to_csv('list.csv', index=False)



## OPTIONAL

#words = ["Here", "I","want","to","concatenate","words","using","pipe","delimeter"]
#"|".join(words)

# Create markdown expression for link sharing
#NAMES = df['name']

#urls = ["[Link zu dem Notebook](https\\\\" + str(NAME) + "whatever)" for NAME in NAMES]
#for url in urls:
#    urls.append(url)

# Create dataframes
#df3 = pd.DataFrame(urls, columns=["url"])


#df3.to_csv('url.csv', index=False)