#!/usr/bin/perl -w
#
#usage : perl plit_kmer.pl all.list 
#all.list is the output file from filterx
#
open IN,"$ARGV[0]" || die;
open MM,">Mf.list" || die;
open FF,">mF.list" || die;
while (<IN>){
chomp;
my @a = split;


my $count = 1;
my $mm = 0;
my $ff = 0;
for (;$count <= $#a;$count++){
if ($count <= 20){
if ($a[$count] =~ /-/){
$mm++;
}
}elsif ($count >= 21){
if ($a[$count] =~ /-/){
$ff++;
}
}
}


if ($mm == 20){
print FF "$a[0]\t$a[21]\t$a[22]\t$a[23]\t$a[24]\t$a[25]\t$a[26]\t$a[27]\t$a[28]\t$a[29]\t$a[30]\t$a[31]\t$a[32]\t$a[33]\t$a[34]\t$a[35]\t$a[36]\t$a[37]\t$a[38]\t$a[39]\t$a[40]\n";
}elsif ($ff == 20){
print MM "$a[0]\t$a[1]\t$a[2]\t$a[3]\t$a[4]\t$a[5]\t$a[6]\t$a[7]\t$a[8]\t$a[9]\t$a[10]\t$a[11]\t$a[12]\t$a[13]\t$a[14]\t$a[15]\t$a[16]\t$a[17]\t$a[18]\t$a[19]\t$a[20]\n";
}
}

close IN;
close MM;
close FF;
