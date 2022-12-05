#!usr/bin/perl -w

$work_dir=$ARGV[0];

open(IN,"$work_dir/gencode.v42.basic.annotation.gtf");
open(OUT,">$work_dir/GENCODE.V42.basic.CHR.gtf");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	if($raw=~/^#/)
	{
		print OUT "$raw\n";
	}
	else
	{
		if($raw=~/\ttranscript\t/)
		{
			$raw=~/transcript_id "([^\"\;]+)/;
			$transcript_id=$1;
			if($raw=~/gene_id "([^\"\;]+)/)
			{
				$gene_id=$1;
				$transcript_gene_id_mapping{$transcript_id}=$gene_id;
				#print "$transcript_id\t$gene_id\n";
			}
			if($raw=~/protein_id/)
			{
				$raw=~/protein_id "([^\"\;]+)/;
				$protein_id=$1;
				$transcript_protein_id_mapping{$transcript_id}=$protein_id;
			}
			else
			{
				$transcript_protein_id_mapping{$transcript_id}="NA";
			}
		}
		$raw=~s/\.\d+\"\;/\"\;/g;
		$raw=~s/\.\d+_PAR_Y\"\;/_PAR_Y\"\;/g;
		print OUT "$raw\n";		
	}
}
close(IN);
close(OUT);

open(OUT_2,">$work_dir/GENCODE.V42.basic.CHR.versioned.ID.mapping.txt");

print OUT_2 "Gene_id\tTranscript_id\tProtein_id\tGene_id_versioned\tTranscript_id_versioned\tProtein_id_versioned\n";

foreach $transcript_id (keys %transcript_gene_id_mapping)
{
	$transcript_id_no_version=$transcript_id;
	$gene_id_no_version=$transcript_gene_id_mapping{$transcript_id};
	$protein_id_no_version=$transcript_protein_id_mapping{$transcript_id};
	$transcript_id_no_version=~s/\.\d+//;
	$gene_id_no_version=~s/\.\d+//;
	$protein_id_no_version=~s/\.\d+//;
	$transcript_id_no_version=~s/\.\d+_PAR_Y/_PAR_Y/;
	$gene_id_no_version=~s/\.\d+_PAR_Y/_PAR_Y/;
	$protein_id_no_version=~s/\.\d+_PAR_Y/_PAR_Y/;
	print OUT_2 "$gene_id_no_version\t$transcript_id_no_version\t$protein_id_no_version\t$transcript_gene_id_mapping{$transcript_id}\t$transcript_id\t$transcript_protein_id_mapping{$transcript_id}\n"
}
close(OUT_2);
