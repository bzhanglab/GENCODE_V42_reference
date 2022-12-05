#!use/bin/perl -w

$work_dir=$ARGV[0];

open(OUT,">$work_dir/GENCODE.V42.basic.CHR.ig.tr.nmd.lof.fa");
open(IN,"$work_dir/GENCODE.V42.basic.CHR.protein.selection.mapping.ig.tr.nmd.lof.txt");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;

	@inf=split(/\t/,$raw);
	if($inf[23] eq "Yes")
	{
		$inf[0]=~s/\.\d+//;
		$inf[2]=~s/\.\d+//;
		print OUT ">$inf[2]|$inf[1]|$inf[0]|$inf[4]";
		if($inf[25] ne "NA")
		{
			print OUT " $inf[25]\n";
		}
		else
		{
			print OUT "\n"
		}
		print OUT "$inf[24]\n";
	}
}
close(IN);

close(OUT);
