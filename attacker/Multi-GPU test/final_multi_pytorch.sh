#!/bin/bash

git clone https://github.com/dnddnjs/pytorch-multigpu.git

python3 -m venv multi-env
source multi-env/bin/activate
pip install --upgrade pip
pip install torchvision
pip install tensorboardX
cd pytorch-multigpu/
