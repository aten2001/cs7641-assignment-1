#!/usr/bin/env bash

cat winequality-white.csv > winequality.csv
sed '1d' winequality-red.csv >> winequality.csv