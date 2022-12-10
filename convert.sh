# Create all HTML slides in this folder
jupyter nbconvert *_p.ipynb --to slides --reveal-prefix reveal.js



# OPTIONAL 

# jupyter nbconvert 10a-application-model-exploration.ipynb --to slides --reveal-prefix reveal.js


# Convert all HTML-files to PDF with headless Chrome
# Issue: produces only horizontal pages

# alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# for i in $(ls *.html); do 
#    chrome --headless --disable-gpu --print-to-pdf="$i".pdf "$i"
# done

# List all HTML files
# ls *.html

# Other option to list html-files in directory
# find . -maxdepth 1 -name '*.html'

# ls *.html > files.csv