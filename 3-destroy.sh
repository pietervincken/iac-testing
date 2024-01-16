#!/bin/bash

cd terraform

tofu init -upgrade
tofu destroy -auto-approve

cd ..