#!/usr/bin/perl -w

$BOLTZMANN = 0.001987191; 
$RT = $BOLTZMANN * 310.15;

$left_rest_num = 0;
$fep_win_num = 128;
$start_win = $left_rest_num;
$end_win = $left_rest_num + $fep_win_num -1;
$jobid = $ARGV[0];
my @all_fepout = <output_off/*/*job$jobid.*.sort.history>;
my $dG = 0.0;
my $ncount = 0;

nextmol: foreach $i (@all_fepout) {

  my @file_name = split /\//, $i;
  if ( $file_name[1] >= $end_win || $file_name[1] < $start_win ) {
  } else { 
  open(FE_VDW, "<${i}") or die "Can't open file ${i}: $!";

my $count = 0;
my $exp_dE_ByRT_0 = 0.0;
my $exp_dE_ByRT_1 = 0.0;
NEXT:  while ($line = <FE_VDW>) {
    chomp $line;
    my @fields = split /\s+/, $line;
 
   if ( $fields[1] < $fields[2] ) { 
    $count += 1;

    my $del_u_0 = $fields[5] - $fields[4];
    my $del_u_1 = $fields[6] - $fields[7];
   $exp_dE_ByRT_0 += exp(-$del_u_0/(2.0 * $RT));
   $exp_dE_ByRT_1 += exp($del_u_1/(2.0 * $RT));
   }
  }
my $ave_exp_dE_ByRT_0 = $exp_dE_ByRT_0/$count;
my $ave_exp_dE_ByRT_1 = $exp_dE_ByRT_1/$count;

$dG += -($RT * log($ave_exp_dE_ByRT_0/$ave_exp_dE_ByRT_1));
close FE_VDW;
 } 
}

printf "%-10.5f\n", $dG;

