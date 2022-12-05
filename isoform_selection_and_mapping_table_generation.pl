#!usr/bin/perl -w

use Getopt::Long qw(:config no_auto_abbrev);
use Pod::Usage;
use File::Basename;
use FindBin;
use lib $FindBin::RealBin;

use Env qw(@PATH);

@PATH = ($FindBin::RealBin, @PATH);

$work_dir="$PATH[0]/annotation";
$script_dir="$PATH[0]/scripts/";
$current_dir=$PATH[0];

#######remove version number and keep versioned ID in file annotation/GENCODE.V42.basic.CHR.versioned.ID.mapping.txt
#`perl $script_dir/remove-version-from-gtf.pl $work_dir`;

#######extracted ccds and transcript length
#`perl $script_dir/expracted_ccds_length_transcript_length.pl $work_dir`;

#######generate comprehensive mapping table
#`perl $script_dir/generate_mapping_table.pl $work_dir $current_dir`;

#######isoform selection
#`Rscript $script_dir/primary_and_secondary_selected_table_with_multiple_gene_mapping_processing.r $work_dir $current_dir`;

#######filter annotation with selected isoform
`perl $script_dir/extracted-gene-annotation-of-primary-selected-isoform.pl $work_dir`;
