dvc pull
git submodule update --init --remote
cd GEMS-MagTIP-insider && dvc pull

# For error "julia kernel not found", please update `index.qmd`.
cd .. && quarto render --profile en && quarto render --profile zhtw

