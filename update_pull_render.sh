dvc pull
git submodule update --init --remote
cd GEMS-MagTIP-insider && dvc pull
cd .. && quarto render --profile en && quarto render --profile zhtw

