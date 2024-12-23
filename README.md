# README

[Documentation for GEMS-MagTIP](https://cgrg-lab.github.io/GEMS-MagTIP/).


## For the maintainer of this website

### Quarto source code

To view Quarto source code (`.qmd`), please click on the code tool button at the top-right.
See https://quarto.org/docs/output-formats/html-code.html#code-tools. 

### Website deployment

The deployment for this website is via the workflows in [static.yml](.github/workflows/static.yml) when pushing to the remote main branch, following the instruction [Render to `docs`](https://quarto.org/docs/publishing/github-pages.html#render-to-docs).

Settings in Github Pages: 
- The static source is chosen as "Github Actions" with "Static HTML".
- Deploy the site based on branch `main` at directory `./docs`.

The website is rendered on local, based on the contents of DVC tracked files and the [submodule GEMS-MagTIP-insider](#Submodule-GEMS-MagTIP-insider).

There is a unix-based shell script [update_pull_render.sh](update_pull_render.sh); 
run `. update_pull_render.sh` to pull contents from DVC remote, update the submodule, and run quarto render for all profiles at once.

### Translation to zh-TW

The zh-TW contents (中文版內容) lives under https://cgrg-lab.github.io/GEMS-MagTIP/zh-TW, whereas 
the English contents lives under https://cgrg-lab.github.io/GEMS-MagTIP/zh-TW.
The zh-TW is translated from English contents.

#### Rule

The headers in [/doc_library/index.qmd](/doc_library/index.qmd) were intended to be identical for both language version, in order to avoid the necessity to fix reference links in the post processes.
Please don't translate headers (that starts with one or multiple `#`) in [/doc_library/index.qmd](/doc_library/index.qmd).

#### When assisted with ChatGPT

A code block may result in ChatGPT translation output error. 
To avoid this, please find all code blocks in the documents and manually 
remove them before feeding the qmd script to ChatGPT. 

Here are regular expression that might be helpful: 
- ```.*\n+([\n\s\r]|.)*?```
- (信息|過濾|篩選|震級|克隆|功能|加載|概率)

#### Language toggle button

There is a language toggle function in the navigation bar.
This button (icon: [translate](https://icons.getbootstrap.com/icons/translate/)) calls a JavaScript function `toggleLang()` and returns modified url. 
Here are associated files:
- [`toggle-lang.html`](toggle-lang.html)
- [`_quarto.yml`](_quarto.yml).website.navbar

For including JavaScript in quarto, see
- https://github.com/quarto-dev/quarto-cli/discussions/4179

### Submodule GEMS-MagTIP-insider

This documentation depends on the submodule [GEMS-MagTIP-insider](https://github.com/okatsn/GEMS-MagTIP-insider.git). 
However, there is no straightforward way to establish a dependency based on submodule change, since the submodule commit hash is stored in `.git`, not available in the working directory.
As a result, manage the website rendering workflow as a DVC pipeline is ridiculous since you requires a stage for `dvc pull` for the workspace, a stage of updating submodule, a stage of `dvc pull` in the submodule directory, and you have to `quarto render` anyway every time because there is no dependency between each stage at all.

Instead, using a shell script to do these things is much straightforward.