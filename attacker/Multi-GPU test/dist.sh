#!/bin/bash


cd dist_parallel
python train.py --gpu_device 0 1 2 3 --batch_size 32
