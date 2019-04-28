#!/usr/bin/perl -w
#
#usage : perl split_depth.pl depth.file
#the result must output in same folder named with sample name.
#
open IN,"$ARGV[0]" || die;
open OUT,">00.list" || die;

my $name;
if ($ARGV[0] =~ /Mf/){
$ARGV[0] =~ /(Mf\d+)/;
$name = $1;
}elsif ($ARGV[0] =~ /mF/){
$ARGV[0] =~ /(mF\d+)/;
$name = $1;
}

my %A;
while (<IN>){
chomp;
my @a = split;
if ($A{$a[0]}){
print OUT "$a[1]\t$a[2]\n";
}else{
close OUT;
open OUT,">$a[0].$name";
$A{$a[0]} = 1;
print OUT "$a[0]\n$a[1]\t$a[2]\n";
}
}

close IN;
close OUT;
