#!/usr/bin/perl -w

$num_replicas = 128;
system("mkdir output_site");
for ($i=0; $i < $num_replicas; $i++) {

system("mkdir output_site/$i");
#system("mkdir output_solv/$i");
}
