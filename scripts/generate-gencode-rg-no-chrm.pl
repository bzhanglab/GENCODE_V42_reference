#!usr/bin/perl -w

$work_dir=$ARGV[0];
$current_dir=$ARGV[1];

$title="refseq	gene	symb	locus_id	chr	strand	start	end	cds_start	cds_end	status	chrn";

%transcript_strand=();
%transcript_chr=();
%transcript_gene=();
%transcript_start=();
%transcript_end=();
%cds_start=();
%cds_end=();

open(IN,"$current_dir/annotation/GENCODE.V42.basic.CHR.gtf");
while($raw=<IN>)
{
	if($raw=~/	transcript	/)
	{
		@inf=split(/\t/,$raw);
		if($raw=~/gene_id "([^\"\;]+)/)
		{
			$gene_id=$1;
			$gene_id=~s/\.\d+//;
		}
		if($raw=~/ transcript_id "([^\"\;]+)/)
		{
			$transcript_id=$1;
			$transcript_id=~s/\.\d+//;
		}
		$transcript_gene{$transcript_id}=$gene_id;
		if($inf[6] eq "+")
		{
			$transcript_strand{$transcript_id}=1;
		}
		else
		{
			$transcript_strand{$transcript_id}=0;
		}
		$transcript_start{$transcript_id}=$inf[3];
		$transcript_end{$transcript_id}=$inf[4];
		$inf[0]=~s/chr//;
		$transcript_chr{$transcript_id}=$inf[0];
	}
	if($raw=~/	CDS	/)
	{
		@inf=split(/\t/,$raw);
		if($raw=~/ transcript_id "([^\"\;]+)/)
		{
			$transcript_id=$1;
			$transcript_id=~s/\.\d+//;
		}
		if(!exists($cds_start{$transcript_id}))
		{
			$cds_start{$transcript_id}=$inf[3];
			$cds_end{$transcript_id}=$inf[4];
		}
		else
		{
			if($cds_start{$transcript_id}>$inf[3])
			{
				$cds_start{$transcript_id}=$inf[3];
			}
			if($cds_end{$transcript_id}<$inf[4])
			{
				$cds_end{$transcript_id}=$inf[4];
			}
		}
	}
}
close(IN);



print "Total mapping: \t",scalar (keys(%transcript_chr)),"\n";

open(OUT,">$work_dir/rg_raw.txt");
print OUT "$title\n";
foreach $transcript_id (keys(%transcript_chr))
{
	if($transcript_chr{$transcript_id} ne "M")
	{
		print OUT "$transcript_id\t\t$transcript_gene{$transcript_id}\t\tchr$transcript_chr{$transcript_id}\t$transcript_strand{$transcript_id}\t$transcript_start{$transcript_id}\t$transcript_end{$transcript_id}\t";
		if(exists($cds_start{$transcript_id}))
		{
			print OUT "$cds_start{$transcript_id}\t$cds_end{$transcript_id}\t";
		}
		else
		{
			print OUT "$transcript_end{$transcript_id}\t$transcript_end{$transcript_id}\t";
		}
		print OUT "reviewed\t$transcript_chr{$transcript_id}\n";
	}
}
close(OUT);
