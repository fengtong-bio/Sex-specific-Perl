#!/usr/bin/perl -w
#
#usage : perl depth_filtrate.pl mF.file.list 2 20 > outfile
#mF.file.list is the ctg name from soapdenovo list file, only ctg name
#2 means calculate site.
#20 means 20 sample`s depth have to > 0.
#
open IN,"$ARGV[0]" || die;
my $shu = $ARGV[2];

while (<IN>){
chomp;
my $aa = $_;

open IN1,"./sum2/$aa" || die;
my $qian;
my $hou;
if ($ARGV[1] == 1){
$qian = $shu;
$hou = 0;
}elsif ($ARGV[1] == 2){
$qian = 0;
$hou = $shu;
}
my $count;
my $count2 = 0;
my $count3 = 0;
my $weizhi = "aa";
my @ww;
while (<IN1>){
chomp;
my $qian1 = 0;
my $hou1 = 0;
my @a = split;
for ($count = 1;$count <= $#a;$count++){
if ($count <= 20){
if ($a[$count] == 0){
$qian1 += 0;
}elsif ($a[$count] >= 1){
$qian1 += 1;
}
}else{
if ($a[$count] == 0){
$hou1 += 0;
}elsif ($a[$count] >= 1){
$hou1 += 1;
}
}
}
if ($qian1 == $qian && $hou1 == $hou){
$count2++;
push(@ww,$a[0]);
}
$count3++;
}
my $count4 = ($count2/$count3);
my @sww = sort @ww;
if ($count2 > 0){
print "$aa\t$count2\t$count3\t$count4\t$weizhi\t@sww\n";
}
close IN1;
}
close IN;
