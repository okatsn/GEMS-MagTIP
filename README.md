# README

This site is live at  https://cgrg-lab.github.io/GEMS-MagTIP/.


## For the maintainer of this website

### Translation to zh-TW

#### Rule

The headers in `/doc_library/index.qmd` will have only English version in order to avoid the necessity to fix reference links in the post-process.

#### When assisted with ChatGPT

A code block may result in ChatGPT translation output error. 
To avoid this, please find all code blocks in the documents and manually 
remove them before feeding the qmd script to ChatGPT. 
Here is a helpful regular expression: ```.*\n+([\n\s\r]|.)*?```

### Submodule GEMS-MagTIP-insider

This documentation depends on the submodule [GEMS-MagTIP-insider](https://github.com/okatsn/GEMS-MagTIP-insider.git). 
However, there is no straightforward way to establish a dependency based on submodule change, since the submodule commit hash is stored in `.git`, not available in the working directory.
As a result, manage the website rendering workflow as a DVC pipeline is ridiculous since you requires a stage for `dvc pull` for the workspace, a stage of updating submodule, a stage of `dvc pull` in the submodule directory, and you have to `quarto render` anyway every time because there is no dependency between each stage at all.

Instead, using a shell script to do these things is much straightforward.