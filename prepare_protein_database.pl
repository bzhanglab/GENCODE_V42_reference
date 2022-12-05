#!usr/bin/perl -w

use Getopt::Long qw(:config no_auto_abbrev);
use Pod::Usage;
use File::Basename;
use FindBin;
use lib $FindBin::RealBin;

use Env qw(@PATH);

@PATH = ($FindBin::RealBin, @PATH);

$work_dir="$PATH[0]/protein_database";
$script_dir="$PATH[0]/scripts/";
$current_dir=$PATH[0];

#######filter proteins in basic chr annotation
#`perl $script_dir/filter_basic_protein.pl $work_dir $current_dir`;

#######get protein group
#`perl $script_dir/protein_group.pl $work_dir`;

#######fitler protein by our method
#`Rscript $script_dir/filter-protein.r $work_dir  $current_dir`;

#######filter contaminants and reformat contaminant database
#`perl $script_dir/filter_contaminants_and_reformat_database.pl $work_dir`;

#######reformat protein database and add contaminants
`perl $script_dir/to-UniProt-format.pl $work_dir`;
`perl $script_dir/to-UniProt-format-ig-tr-nmd-lof.pl $work_dir`;

