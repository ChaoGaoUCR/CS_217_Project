#!/bin/bash

cd data_parallel
python train.py --gpu_devices 0 1 2 3 --batch_size 32
