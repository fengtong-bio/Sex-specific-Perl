#!/usr/bin/perl -w
#
#usage : perl sum_depth.pl mF.list file.list
#mF.list is the contig name from soapdenovo list file, including > and the number postfix.
#file.list is the folder name from split_depth.pl
#
open GENE,"$ARGV[0]" || die;
open NAME,"$ARGV[1]" || die;

my %A;
my %B;
while (<NAME>){
chomp;
my $aa = $_;
$A{$aa} = 0;
}

while (<GENE>){
chomp;
my $bb = $_;
$bb =~ />(\S+)/;
my $cc = $1;
foreach (keys %A){
my $dd = $_;
open IN,"./$dd/$cc.$dd" || die;
my $count = 0;
while (<IN>){
chomp;
my @a = split;
$B{$count} .= "\t$a[1]"; 
$count++;
}
close IN;
}

open OUT,">./sum/$cc" || die;
foreach (keys %B){
print OUT "$_$B{$_}\n";
}

%B = ();
close OUT;
}
