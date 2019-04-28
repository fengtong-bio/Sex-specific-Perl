#!/usr/bin/perl -w
#
#usage : perl kmer.reads.use.pl fq_file.list
#fq_file.list is the fq file`s path.
#
open IN1,"$ARGV[0]" || die;
open IN2,"gzip -dc $ARGV[1]|" || die;
open OUT1,">$ARGV[2].all" || die;
open OUT2,">$ARGV[2].name" || die;
open OUT3,">$ARGV[2].number" || die;
open OUT4,">$ARGV[2].fq" || die;

my %K;
$/ = ">";
<IN1>;
while (<IN1>){
chomp;
$_ =~ /(\S+)\s+(\S+)/;
my $kname = $1;
my $kfa = $2;
$K{$kfa} = $kname;
}

my %R;
my %M;
my %N;
$/= "@";
<IN2>;
while (<IN2>){
chomp;
$_ =~ /(\S+)\s+\S+\s+(\S+)\s+\+/;
my $rname = $1;
my $rfa = $2;
my $long = length $rfa;
my $site = 0;
for (;$site <= ($long - 21);$site++){
my $seq = substr($rfa,$site,21);
my $fseq = $seq;
$fseq =~ tr/ACGT/TGCA/;
$fseq = reverse $fseq;
chomp ($fseq);
chomp ($seq);
if (exists $K{$seq}){
my $kmer = $K{$seq};
$R{$kmer} .= "\t$rname";
}elsif (exists $K{$fseq}){
my $kmer = $K{$fseq};
$R{$kmer} .= "\t$rname";
}
}
next;
}

foreach (keys %R){
print OUT1 "$_\t$R{$_}\n";
}
close OUT1;

my %L;
open INR,"$ARGV[2].all" || die;
my $rcount = 0;
$/ = "\n";
<INR>;
while (<INR>){
chomp;
my @rr = split;
my $rrr = 1;
while ($rrr <= $#rr){
my $m = $rr[$rrr];
if ($L{$m}){
$rcount++;
}else{
$M{$rr[0]} .= "\t$m";
$N{$rr[0]} += 1;
$L{$m} = 1;
}
%L = ();
$rrr++;
}
next;
}

close INR;
foreach (keys %M){
print OUT2 "$_\t$M{$_}\n";
}
foreach (keys %N){
print OUT3 "$_\t$N{$_}\n";
}

close IN1;
close IN2;
close OUT1;
close OUT3;

my %A;
open IN3,"$ARGV[2].name" || die;
$/ = "\n";
<IN3>;
while (<IN3>){
chomp;
my @a = split;
if ($N{$a[0]} >=1){
my $counta = 1;
for ($counta <= $#a){
$A{$a[$counta]} = 1;
$counta++;
}
}
}

open IN2,"gzip -dc $ARGV[1]|" || die;
$/ = "@";
<IN2>;
while (<IN2>){
chomp;
my $cc = $_;
$_ =~ /(\S+)\s+/;
my $bb = $1;
if ($A{$bb}){
print OUT4 "\@$cc";
}
}

close IN2;
close OUT4;
