#!/usr/bin/perl -w
#
#usage : perl fq2.pl *1.fq *2.fq
# *fq is the fq result from kmer.reads.fq.pl for each smple
#
$ARGV[0] =~ /(ACSC\S+clean)/;
my $aa = $1;
$ARGV[1] =~ /(ACSC\S+clean)/;
my $bb = $1;
my $in1;
my $in11;
my $in2;
my $in22;
$in1 = $ARGV[0];
$in11 = "$aa.fq.gz.P.qtrim.gz";
$in2 = $ARGV[1];
$in22 = "$bb.fq.gz.P.qtrim.gz";

open IN1,"$in1" || die;
open IN2,"$in2" || die;
open IN11,"gzip -dc $in11|" || die;
open IN22,"gzip -dc $in22|" || die;
open OUT1,">$in1.all" || die;
open OUT2,">$in2.all" || die;

my %A;
$/ = "@";
<IN1>;
while (<IN1>){
chomp;
my $cc = $_;
$cc =~ /(\S+)\s+/;
my $dd = $1;
$A{$dd} = 1;
}

$/ = "@";
<IN2>;
while (<IN2>){
chomp;
my $ee = $_;
$ee =~ /(\S+)\s+/;
my $jj = $1;
if ($A{$jj}){
$A{$jj}++;
}else{
$A{$jj} = 1;
}
}

$/ = "@";
<IN11>;
while (<IN11>){
chomp;
my $ff = $_;
$ff =~ /(\S+)\s+/;
my $gg = $1;
if ($A{$gg}){
print OUT1 "\@$ff";
}
}

$/ = "@";
<IN22>;
while (<IN22>){
chomp;
my $hh = $_;
$hh =~ /(\S+)\s+/;
my $ii = $1;
if ($A{$ii}){
print OUT2 "\@$hh";
} 
}
close IN1;
close IN2;
close IN11;
close IN22;
close OUT1;
close OUT2;
