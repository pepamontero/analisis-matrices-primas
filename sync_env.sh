#!/bin/bash
echo "Recreating the environment from environment.yml..."
micromamba deactivate
micromamba remove -n r-env --yes --all
micromamba create -n r-env -f environment.yml --yes
echo "Environment re-created. Run: micromamba activate r-env"
