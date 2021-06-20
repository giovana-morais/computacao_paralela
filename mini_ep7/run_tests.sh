#!/bin/bash

gcc parallelFor.c -o parallel -fopenmp

for i in {1..10}; do
	time ./parallel
done
