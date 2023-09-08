#!/usr/bin/perl -w

for ($j = 0; $j < 128; $j++) {
     system("python sort.py $j");
}
