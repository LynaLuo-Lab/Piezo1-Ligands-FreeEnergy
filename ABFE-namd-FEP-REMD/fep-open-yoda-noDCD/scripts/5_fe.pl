#!/usr/bin/perl -w

system (" rm -rf calc_fe.dat");

$my_sum = 0;
$init_run = 0;
$num_runs=100;
for ($j = $init_run; $j < $num_runs; $j++) {
     system("./calc_fe.pl $j >> calc_fe.dat");
          }

open(FE_VDW, "<calc_fe.dat") or die "Can't open file calc_fe.dat: $!";

NEXT:  while ($line = <FE_VDW>) {
    chomp $line;
    my @fields = split /\s+/, $line;
    my $dG = $fields[0];
   $my_sum += $dG;
  }

my $ave_dG = $my_sum/($num_runs-$init_run);

printf "%-10.5f\n", $ave_dG;
