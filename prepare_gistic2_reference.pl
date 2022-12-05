#!usr/bin/perl -w

use Getopt::Long qw(:config no_auto_abbrev);
use Pod::Usage;
use File::Basename;
use FindBin;
use lib $FindBin::RealBin;

use Env qw(@PATH);

@PATH = ($FindBin::RealBin, @PATH);

$work_dir="$PATH[0]/gistic_reference";
$script_dir="$PATH[0]/scripts/";
$current_dir=$PATH[0];

#######prepare rg file
`perl $script_dir/generate-gencode-rg-no-chrm.pl $work_dir $current_dir`;

#######sort rg file
`Rscript $script_dir/reformat-rg.r $work_dir`;

####################
`cp $script_dir/main_convert.m $work_dir/main_convert.m`;

