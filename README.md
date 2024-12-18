# README

## For the maintainer of this website

### Translation to zh-TW

#### Rule

The headers in `/doc_library/index.qmd` will have only English version in order to avoid the necessity to fix reference links in the post-process.

#### When assisted with ChatGPT

A code block may result in ChatGPT translation output error. 
To avoid this, please find all code blocks in the documents and manually 
remove them before feeding the qmd script to ChatGPT. 
Here is a helpful regular expression: ```.*\n+([\n\s\r]|.)*?```

