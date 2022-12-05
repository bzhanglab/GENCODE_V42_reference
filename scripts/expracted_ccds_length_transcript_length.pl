#!usr/bin/perl -w

$work_dir=$ARGV[0];

%transcript_lenght=();
%ccds_lenght=();
open(IN,"$work_dir/GENCODE.V42.basic.CHR.gtf");
while($raw=<IN>)
{
	if($raw=~/ transcript_id /&&$raw=~/\texon\t/)
	{
		if($raw=~/ transcript_id "([^\"\;]+)/)
		{
			$transcript_id=$1;
		}
		@inf=split(/\t/,$raw,7);
		if(exists($transcript_lenght{$transcript_id}))
		{
			$transcript_lenght{$transcript_id}+=($inf[4]-$inf[3]+1);
		}
		else
		{
			$transcript_lenght{$transcript_id}=$inf[4]-$inf[3]+1;
		}
	}
	if($raw=~/ transcript_id /&&$raw=~/\tCDS\t/)
	{
		if($raw=~/ transcript_id "([^\"\;]+)/)
		{
			$transcript_id=$1;
		}
		@inf=split(/\t/,$raw,7);
		if(exists($ccds_lenght{$transcript_id}))
		{
			$ccds_lenght{$transcript_id}+=($inf[4]-$inf[3]+1);
		}
		else
		{
			$ccds_lenght{$transcript_id}=$inf[4]-$inf[3]+1;
		}
	}
}
close(IN);

open(OUT,">$work_dir/GENCODE.V42.basic.CHR.CDS.transcript.length.txt");
print OUT "idx\tTranscript_length\tCCDS_length\n";
foreach $transcript_id (keys(%transcript_lenght))
{
	print OUT "$transcript_id\t$transcript_lenght{$transcript_id}\t";
	if(exists($ccds_lenght{$transcript_id}))
	{
		print OUT "$ccds_lenght{$transcript_id}\n";
	}
	else
	{
		print OUT "NA\n";
	}
}

close(OUT);



