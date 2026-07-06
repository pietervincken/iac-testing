#!/bin/bash

python3.13 -m venv .venv
source .venv/bin/activate
which python
python3.13 -m pip install -r src/requirements.txt
