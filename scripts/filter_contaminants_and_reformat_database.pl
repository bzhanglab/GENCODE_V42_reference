#!usr/bin/perl -w

$work_dir=$ARGV[0];

%gencode_v42_protein_sequence_to_id=();

open(IN,"$work_dir/GENCODE.V42.basic.CHR.protein.selection.mapping.txt");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	@raw_inf=split(/\t/,$raw);
	$gencode_v42_protein_sequence_to_id{$raw_inf[24]}=$raw_inf[2];
}
close(IN);


#########################################################################################

%maxquant_contaminants_id_to_sequence=();
open(IN,"$work_dir/maxquant_contaminants.fasta");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	if($raw=~/^>/)
	{
		$raw=~s/>//g;
		$protein_id=$raw;
		#@raw_inf=split(/\|/,$raw);
		#$protein_id="$raw_inf[0]|$raw_inf[1]|$raw_inf[2]";
	}
	else
	{
		if(exists($maxquant_contaminants_id_to_sequence{$protein_id}))
		{
			$maxquant_contaminants_id_to_sequence{$protein_id}.=$raw;
		}
		else
		{
			$maxquant_contaminants_id_to_sequence{$protein_id}=$raw;
		}
	}
}
close(IN);


%maxquant_contaminants_sequence_to_ID=();

foreach $protein_id (keys(%maxquant_contaminants_id_to_sequence))
{
	if(!exists($maxquant_contaminants_sequence_to_ID{$maxquant_contaminants_id_to_sequence{$protein_id}}))
	{
		$maxquant_contaminants_sequence_to_ID{$maxquant_contaminants_id_to_sequence{$protein_id}}=$protein_id;
	}
	else
	{
		print "$protein_id\n";
		print "$maxquant_contaminants_id_to_sequence{$protein_id}\n";
	}

}


$remain_number=1;
open(OUT,">$work_dir/maxquant_contaminants_filtered.fasta");
foreach $protein_sequence (sort keys(%maxquant_contaminants_sequence_to_ID))
{
	if(!exists($gencode_v42_protein_sequence_to_id{$protein_sequence}))
	{
		print OUT ">$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n$protein_sequence\n";
	}
	else
	{
		print "$remain_number\t$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n";
		$remain_number++;
	}
}
close(OUT);


$remain_number=1;
open(OUT,">$work_dir/maxquant_contaminants_filtered_reformatted.fasta");
foreach $protein_sequence (sort keys(%maxquant_contaminants_sequence_to_ID))
{
	if(!exists($gencode_v42_protein_sequence_to_id{$protein_sequence}))
	{
		print OUT ">Cont|$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n$protein_sequence\n";
	}
	else
	{
		print "$remain_number\t$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n";
		$remain_number++;
	}
}
close(OUT);


%maxquant_contaminants_sequence_to_ID_maxquant=%maxquant_contaminants_sequence_to_ID;

print "maxquant\t",scalar(keys(%maxquant_contaminants_sequence_to_ID_maxquant)),"\n";

#########################################################################################

%maxquant_contaminants_id_to_sequence=();

%id_list=();

open(IN,"$work_dir/UniProtContams_642_20221013_Karl.fasta");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	if($raw=~/^>/)
	{
		$raw=~s/>//g;
		$raw=~s/>//g;
		$protein_id=$raw;
		if(!exists($id_list{$protein_id}))
		{
			$id_list{$protein_id}=1;
		}
		else
		{
			print "$protein_id\n";
		}

		#@raw_inf=split(/\|/,$raw);
		#$protein_id="$raw_inf[0]|$raw_inf[1]|$raw_inf[2]";
	}
	else
	{
		if(exists($maxquant_contaminants_id_to_sequence{$protein_id}))
		{
			$maxquant_contaminants_id_to_sequence{$protein_id}.=$raw;
		}
		else
		{
			$maxquant_contaminants_id_to_sequence{$protein_id}=$raw;
		}
	}
}
close(IN);

print scalar(keys(%maxquant_contaminants_id_to_sequence)),"\n";


%maxquant_contaminants_sequence_to_ID=();

foreach $protein_id (keys(%maxquant_contaminants_id_to_sequence))
{
	if(!exists($maxquant_contaminants_sequence_to_ID{$maxquant_contaminants_id_to_sequence{$protein_id}}))
	{
		$maxquant_contaminants_sequence_to_ID{$maxquant_contaminants_id_to_sequence{$protein_id}}=$protein_id;
	}
	else
	{
		print "$protein_id\n";
		print "$maxquant_contaminants_id_to_sequence{$protein_id}\n";
	}

}


$remain_number=1;
open(OUT,">$work_dir/UniProtContams_642_20221013_Karl_filtered.fasta");
foreach $protein_sequence (sort keys(%maxquant_contaminants_sequence_to_ID))
{
	if(!exists($gencode_v42_protein_sequence_to_id{$protein_sequence}))
	{
		print OUT ">$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n$protein_sequence\n";
	}
	else
	{
		print "$remain_number\t$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n";
		$remain_number++;
	}
}
close(OUT);


$remain_number=1;
open(OUT,">$work_dir/UniProtContams_642_20221013_Karl_filtered_reformatted.fasta");
foreach $protein_sequence (sort keys(%maxquant_contaminants_sequence_to_ID))
{
	if(!exists($gencode_v42_protein_sequence_to_id{$protein_sequence}))
	{
		$print_id=$maxquant_contaminants_sequence_to_ID{$protein_sequence};
		#$print_id=~s/tr\|//;
		#$print_id=~s/sp\|//;
		print OUT ">Cont|$print_id\n$protein_sequence\n";
	}
	else
	{
		print "$remain_number\t$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n";
		$remain_number++;
	}
}
close(OUT);

%maxquant_contaminants_sequence_to_ID_karl=%maxquant_contaminants_sequence_to_ID;

print "Karl\t",scalar(keys(%maxquant_contaminants_sequence_to_ID_karl)),"\n";

#########################################################################################

%maxquant_contaminants_id_to_sequence=();
open(IN,"$work_dir/GPMDB_cRAp.fasta");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	if($raw=~/^>/)
	{
		$raw=~s/>//g;
		#$raw=~s/>sp\|//g;
		$protein_id=$raw;
		#@raw_inf=split(/\|/,$raw);
		#$protein_id="$raw_inf[0]|$raw_inf[1]|$raw_inf[2]";
	}
	else
	{
		if(exists($maxquant_contaminants_id_to_sequence{$protein_id}))
		{
			$maxquant_contaminants_id_to_sequence{$protein_id}.=$raw;
		}
		else
		{
			$maxquant_contaminants_id_to_sequence{$protein_id}=$raw;
		}
	}
}
close(IN);


%maxquant_contaminants_sequence_to_ID=();

foreach $protein_id (keys(%maxquant_contaminants_id_to_sequence))
{
	if(!exists($maxquant_contaminants_sequence_to_ID{$maxquant_contaminants_id_to_sequence{$protein_id}}))
	{
		$maxquant_contaminants_sequence_to_ID{$maxquant_contaminants_id_to_sequence{$protein_id}}=$protein_id;
	}
	else
	{
		print "$protein_id\n";
		print "$maxquant_contaminants_id_to_sequence{$protein_id}\n";
	}

}


$remain_number=1;
open(OUT,">$work_dir/GPMDB_cRAp_contaminants_filtered.fasta");
foreach $protein_sequence (sort keys(%maxquant_contaminants_sequence_to_ID))
{
	if(!exists($gencode_v42_protein_sequence_to_id{$protein_sequence}))
	{
		print OUT ">$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n$protein_sequence\n";
	}
	else
	{
		print "GPMDB_cRAp\t$remain_number\t$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n";
		$remain_number++;
	}
}
close(OUT);


$remain_number=1;
open(OUT,">$work_dir/GPMDB_cRAp_contaminants_filtered_reformatted.fasta");
foreach $protein_sequence (sort keys(%maxquant_contaminants_sequence_to_ID))
{
	if(!exists($gencode_v42_protein_sequence_to_id{$protein_sequence}))
	{
		print OUT ">Cont|$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n$protein_sequence\n";
	}
	else
	{
		print "$remain_number\t$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n";
		$remain_number++;
	}
}
close(OUT);


%maxquant_contaminants_sequence_to_ID_GPMDB=%maxquant_contaminants_sequence_to_ID;
print "GPMDB\t",scalar(keys(%maxquant_contaminants_sequence_to_ID_GPMDB)),"\n";

#########################################################################################
#########################################################################################


$overlap=0;

foreach $protein_sequence (keys(%maxquant_contaminants_sequence_to_ID_karl))
{
	if(exists($maxquant_contaminants_sequence_to_ID_maxquant{$protein_sequence})&&!exists($gencode_v42_protein_sequence_to_id{$protein_sequence}))
	{
		$overlap++;
	}
}

print "Overlap maxquant and karl proteins: $overlap\n";

$overlap=0;

foreach $protein_sequence (keys(%maxquant_contaminants_sequence_to_ID_karl))
{
	if(exists($maxquant_contaminants_sequence_to_ID_GPMDB{$protein_sequence})&&!exists($gencode_v42_protein_sequence_to_id{$protein_sequence}))
	{
		$overlap++;
	}
}

print "Overlap GPMDB and karl proteins: $overlap\n";

$overlap=0;

foreach $protein_sequence (keys(%maxquant_contaminants_sequence_to_ID_maxquant))
{
	if(exists($maxquant_contaminants_sequence_to_ID_GPMDB{$protein_sequence})&&!exists($gencode_v42_protein_sequence_to_id{$protein_sequence}))
	{
		$overlap++;
	}
}

print "Overlap maxquant and GPMDB proteins: $overlap\n";


$overlap=0;

foreach $protein_sequence (keys(%maxquant_contaminants_sequence_to_ID_maxquant))
{
	if(exists($maxquant_contaminants_sequence_to_ID_GPMDB{$protein_sequence})&&exists($maxquant_contaminants_sequence_to_ID_karl{$protein_sequence})&&!exists($gencode_v42_protein_sequence_to_id{$protein_sequence}))
	{
		$overlap++;
		print "$protein_sequence\n";
	}
}

print "Overlap three cohorts proteins: $overlap\n";

#########################################################################################


%printed_protein_sequence=();
$remain_number=1;
open(OUT,">$work_dir/Merged_contaminants.fasta");
foreach $protein_sequence (sort keys(%maxquant_contaminants_sequence_to_ID_maxquant))
{
	if(!exists($gencode_v42_protein_sequence_to_id{$protein_sequence}))
	{
		print OUT ">Cont|$maxquant_contaminants_sequence_to_ID_maxquant{$protein_sequence}\n$protein_sequence\n";
		$printed_protein_sequence{$protein_sequence}++;
	}
	else
	{
		#print "$remain_number\t$maxquant_contaminants_sequence_to_ID_maxquant{$protein_sequence}\n";
		#$remain_number++;
	}
}

foreach $protein_sequence (sort keys(%maxquant_contaminants_sequence_to_ID_karl))
{
	if(!exists($gencode_v42_protein_sequence_to_id{$protein_sequence})&&!exists($printed_protein_sequence{$protein_sequence}))
	{
		print OUT ">Cont|$maxquant_contaminants_sequence_to_ID_karl{$protein_sequence}\n$protein_sequence\n";
		$printed_protein_sequence{$protein_sequence}++;
	}
	else
	{
		#print "$remain_number\t$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n";
		#$remain_number++;
	}
}

foreach $protein_sequence (sort keys(%maxquant_contaminants_sequence_to_ID_GPMDB))
{
	if(!exists($gencode_v42_protein_sequence_to_id{$protein_sequence})&&!exists($printed_protein_sequence{$protein_sequence}))
	{
		print OUT ">Cont|$maxquant_contaminants_sequence_to_ID_GPMDB{$protein_sequence}\n$protein_sequence\n";
		$printed_protein_sequence{$protein_sequence}++;
	}
	else
	{
		#print "$remain_number\t$maxquant_contaminants_sequence_to_ID{$protein_sequence}\n";
		#$remain_number++;
	}
}

close(OUT);
































