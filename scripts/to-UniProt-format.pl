#!use/bin/perl -w

$work_dir=$ARGV[0];

open(OUT,">$work_dir/GENCODE.V42.basic.CHR.no_contaminants.fa");
open(IN,"$work_dir/GENCODE.V42.basic.CHR.protein.selection.mapping.txt");
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


open(OUT,">$work_dir/GENCODE.V42.basic.CHR.maxquant_contaminants.fa");
open(IN,"$work_dir/GENCODE.V42.basic.CHR.protein.selection.mapping.txt");
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

open(IN,"$work_dir/maxquant_contaminants_filtered_reformatted.fasta");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	print OUT "$raw\n";
}
close(IN);

close(OUT);




open(OUT,">$work_dir/GENCODE.V42.basic.CHR.GPMDB_cRAp_contaminants.fa");
open(IN,"$work_dir/GENCODE.V42.basic.CHR.protein.selection.mapping.txt");
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

open(IN,"$work_dir/GPMDB_cRAp_contaminants_filtered_reformatted.fasta");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	print OUT "$raw\n";
}
close(IN);

close(OUT);





open(OUT,">$work_dir/GENCODE.V42.basic.CHR.immunopeptidomic_contaminants.fa");
open(IN,"$work_dir/GENCODE.V42.basic.CHR.protein.selection.mapping.txt");
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

open(IN,"$work_dir/UniProtContams_642_20221013_Karl_filtered.fasta");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	print OUT "$raw\n";
}
close(IN);

close(OUT);



open(OUT,">$work_dir/GENCODE.V42.basic.CHR.combined_contaminants.fa");
open(IN,"$work_dir/GENCODE.V42.basic.CHR.protein.selection.mapping.txt");
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

open(IN,"$work_dir/Merged_contaminants.fasta");
while($raw=<IN>)
{
	$raw=~s/\n|\r//g;
	print OUT "$raw\n";
}
close(IN);

close(OUT);





