#!/usr/bin/perl -w
$num_runs_old = 1000;

for ($j = 1; $j < 100; $j++) {
    my $jj = $j - 1;
    $num = 1000;

    $num_runs_new = $num_runs_old + $num;
    my $filename = "restart_$j.conf";

    open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";

    print $fh "source fep_site.conf\n";

    print $fh "source [format \$output_root.job$jj.restart$num_runs_old.tcl \"\"\]\n";
    print $fh "set num_runs $num_runs_new\n";
    close $fh;
    $num_runs_old = $num_runs_new;
}

