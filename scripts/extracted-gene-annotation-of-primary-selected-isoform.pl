#!usr/bin/perl -w

$work_dir=$ARGV[0];

%selected_isoform_list=();
open(IN,"$work_dir/GENCODE.V42.basic.CHR.isoform.selection.mapping.txt");
<IN>;
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	@raw_inf=split(/\t/,$raw);
	if($raw_inf[16] eq "Yes")
	{
		$selected_isoform_list{$raw_inf[1]}++;
	}

}
close(IN);

open(IN,"$work_dir/GENCODE.V42.basic.CHR.gtf");
open(OUT,">$work_dir/GENCODE.V42.basic.CHR.primary.selection.gtf");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	if($raw=~/^#/)
	{
		print OUT $raw,"\n";
	}
	elsif($raw=~/\tgene\t/)
	{
		print OUT $raw,"\n";
	}
	elsif($raw=~/transcript_id "/)
	{
		$raw=~/transcript_id "([^\"\;]+)/;
		$transcript_id=$1;
		if(exists($selected_isoform_list{$transcript_id}))
		{
			print OUT $raw,"\n";
		}
	}
}
close(IN);
