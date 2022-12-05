#!usr/bin/perl -w

$work_dir=$ARGV[0];
$current_dir=$ARGV[1];

%transcript_gene_id_mapping=();
%transcript_protein_id_mapping=();
%transcript_gene_name_mapping=();
%transcript_gene_type_mapping=();
%transcript_transcript_type_mapping=();
%transcript_ccdsid_mapping=();
%transcript_MANE_Select=();
%transcript_MANE_Plus_Clinical_Select=();

open(IN,"$work_dir/GENCODE.V42.basic.CHR.gtf");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
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
		if($raw=~/gene_name "([^\"\;]+)/)
		{
			$gene_name=$1;
			if($transcript_id=~/PAR_Y/)
			{
				$gene_name=$gene_name."_PAR_Y";
			}
			$transcript_gene_name_mapping{$transcript_id}=$gene_name;
		}
		if($raw=~/gene_type "([^\"\;]+)/)
		{
			$gene_type=$1;
			$transcript_gene_type_mapping{$transcript_id}=$gene_type;
		}
		if($raw=~/transcript_type "([^\"\;]+)/)
		{
			$transcript_type=$1;
			$transcript_transcript_type_mapping{$transcript_id}=$transcript_type;
		}
		
		if($raw=~/ccdsid/)
		{
			$raw=~/ccdsid "([^\"\;]+)/;
			$ccdsid=$1;
			$transcript_ccdsid_mapping{$transcript_id}=$ccdsid;
		}
		else
		{
			$transcript_ccdsid_mapping{$transcript_id}="NA";
		}
		if($raw=~/MANE_Select/)
		{

			$transcript_MANE_Select{$transcript_id}="Yes";
		}
		else
		{
			$transcript_MANE_Select{$transcript_id}="No";
		}
		if($raw=~/MANE_Plus_Clinical/)
		{

			$transcript_MANE_Plus_Clinical_Select{$transcript_id}="Yes";
		}
		else
		{
			$transcript_MANE_Plus_Clinical_Select{$transcript_id}="No";
		}
	}
}
close(IN);


%transcript_entrez_mapping=();
open(IN,"$current_dir/Metadata_files/gencode.v42.metadata.EntrezGene");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	@raw_inf=split(/\s+/,$raw);
	$raw_inf[0]=~s/\.\d+//;
	$transcript_entrez_mapping{$raw_inf[0]}=$raw_inf[1];
}

%transcript_refseq_mapping=();
open(IN,"$current_dir/Metadata_files/gencode.v42.metadata.RefSeq");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	@raw_inf=split(/\s+/,$raw);
	$raw_inf[0]=~s/\.\d+//;
	if(length($raw_inf[1])==0)
	{
		$raw_inf[1]="NA";
	}
	if(!exists($raw_inf[2]))
	{
		$raw_inf[2]="NA";
	}
	$transcript_refseq_mapping{$raw_inf[0]}="$raw_inf[1]\t$raw_inf[2]";
}


%transcript_swissprot_mapping=();
open(IN,"$current_dir/Metadata_files/gencode.v42.metadata.SwissProt");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	@raw_inf=split(/\s+/,$raw);
	$raw_inf[0]=~s/\.\d+//;
	$transcript_swissprot_mapping{$raw_inf[0]}="$raw_inf[1]";
}


%transcript_length=();
open(IN,"$work_dir/GENCODE.V42.basic.CHR.CDS.transcript.length.txt");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	@raw_inf=split(/\s+/,$raw);
	$raw_inf[0]=~s/\.\d+//;
	$transcript_length{$raw_inf[0]}="$raw_inf[1]\t$raw_inf[2]";
}

open(OUT,">$work_dir/GENCODE.V42.basic.CHR.mapping.table.txt");
print OUT "Gene_id\tTranscript_id\tProtein_id\tGene_name\tGene_type\tTranscript_type\tCCDS_id\tMANE_select\tMANE_Plus_Clinical\tEntrezGene\tRefSeq_RNA\tRefSeq_protein\tSwissProt\tTranscript_length\tCCDS_length\n";
foreach $transcript_id (keys(%transcript_gene_name_mapping))
{
	print OUT "$transcript_gene_id_mapping{$transcript_id}\t$transcript_id\t$transcript_protein_id_mapping{$transcript_id}\t$transcript_gene_name_mapping{$transcript_id}\t$transcript_gene_type_mapping{$transcript_id}\t$transcript_transcript_type_mapping{$transcript_id}\t$transcript_ccdsid_mapping{$transcript_id}\t$transcript_MANE_Select{$transcript_id}\t$transcript_MANE_Plus_Clinical_Select{$transcript_id}";
	if(exists($transcript_entrez_mapping{$transcript_id}))
	{
		print OUT "\t$transcript_entrez_mapping{$transcript_id}";
	}
	else
	{
		print OUT "\tNA";
	}

	if(exists($transcript_refseq_mapping{$transcript_id}))
	{
		print OUT "\t$transcript_refseq_mapping{$transcript_id}";
	}
	else
	{
		print OUT "\tNA\tNA";
	}

	if(exists($transcript_swissprot_mapping{$transcript_id}))
	{
		print OUT "\t$transcript_swissprot_mapping{$transcript_id}";
	}
	else
	{
		print OUT "\tNA";
	}
	print OUT "\t$transcript_length{$transcript_id}";
	print OUT "\n";
}

close(OUT);

