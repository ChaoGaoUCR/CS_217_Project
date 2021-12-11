#!/bin/bash

git clone https://github.com/ChaoGaoUCR/multi-gpu-bwtest.git
cd multi-gpu-bwtest
make all
for varible1 in {1..25}
#for varible1 in 1 2 3 4 5
do
	echo "new iteration"
	./bwtest --do=all:1024:both >> out.txt   
done

	echo "it is over"

