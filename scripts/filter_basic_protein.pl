#!usr/bin/perl -w


$work_dir=$ARGV[0];
$current_dir=$ARGV[1];

%protein_list=();
open(IN,"$current_dir/annotation/GENCODE.V42.basic.CHR.gtf");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	#if($raw=~/protein_id /&&$raw=~/transcript_type "protein_coding"/&&$raw=~/\ttranscript\t/)
	if($raw=~/protein_id /&&$raw=~/\ttranscript\t/)
	{
		$raw=~/protein_id "([^\"\;]+)/;
		$protein_id=$1;	
		$protein_list{$protein_id}++;
	}
}
close(IN);
open(IN,"$work_dir/gencode.v42.pc_translations.fa");
open(OUT,">$work_dir/GENCODE.V42.basic.CHR.pc_translations.fa");
$flag=0;
while($raw=<IN>)
{
	if($raw=~/^>/)
	{
		$raw=~s/>//g;
		$raw=~s/\.\d+\|/\|/g;
		$raw=~s/\.\d+_PAR_Y\|/_PAR_Y\|/g;
		@inf=split(/\|/,$raw);
		if(exists($protein_list{$inf[0]}))
		{
			$flag=1;
		}
		else
		{
			$flag=0;
		}
		if($flag==1)
		{
			print OUT ">$raw";
		}
	}
	else
	{
		if($flag==1)
		{
			print OUT "$raw";
		}
	}
}
close(OUT);






