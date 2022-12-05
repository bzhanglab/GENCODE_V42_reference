#!usr/bin/perl -w

$work_dir=$ARGV[0];

%protein_id_to_sequence=();

$protein_group_id=0;
open(IN,"$work_dir/GENCODE.V42.basic.CHR.pc_translations.fa");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	if($raw=~/^>/)
	{
		$raw=~s/>//g;
		@raw_inf=split(/\|/,$raw);
		$protein_id="$raw_inf[0]|$raw_inf[1]|$raw_inf[2]";
	}
	else
	{
		if(exists($protein_id_to_sequence{$protein_id}))
		{
			$protein_id_to_sequence{$protein_id}.=$raw;
		}
		else
		{
			$protein_id_to_sequence{$protein_id}=$raw;
		}
	}
}
close(IN);


%protein_sequence_to_id_mapping=();
%protein_sequence_to_id_mapping_number=();
foreach $protein_id (keys(%protein_id_to_sequence))
{
	if(exists($protein_sequence_to_id_mapping{$protein_id_to_sequence{$protein_id}}))
	{
		$protein_sequence_to_id_mapping{$protein_id_to_sequence{$protein_id}}=$protein_sequence_to_id_mapping{$protein_id_to_sequence{$protein_id}}.";".$protein_id;
		$protein_sequence_to_id_mapping_number{$protein_id_to_sequence{$protein_id}}++;
	}
	else
	{
		$protein_sequence_to_id_mapping{$protein_id_to_sequence{$protein_id}}=$protein_id;
		$protein_sequence_to_id_mapping_number{$protein_id_to_sequence{$protein_id}}++;
	}	
}

open(OUT,">$work_dir/protein_sequence_to_id_mapping.txt");
open(OUT_2,">$work_dir/protein_group_to_id_mapping.txt");
print OUT "Protein_group_id\tNumber_of_proteins\tID_list\tProtien_sequence\n";
print OUT_2 "Protein_group_id\tNumber_of_proteins\tProtein_id\tTranscript_id\tGene_id\tProtien_sequence\n";
foreach $protein_sequence (sort keys(%protein_sequence_to_id_mapping))
{
	$protein_group_id++;
	print OUT "$protein_group_id\t$protein_sequence_to_id_mapping_number{$protein_sequence}\t$protein_sequence_to_id_mapping{$protein_sequence}\t$protein_sequence\n";
	@id_list=split(/;/,$protein_sequence_to_id_mapping{$protein_sequence});
	foreach $id_name (@id_list)
	{
		$id_name=~s/\|/\t/g;
		print OUT_2 "$protein_group_id\t$protein_sequence_to_id_mapping_number{$protein_sequence}\t$id_name\t$protein_sequence\n";
	}
}
close(OUT);
close(OUT_2);




