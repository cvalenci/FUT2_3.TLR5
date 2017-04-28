#!/bin/bash
#$ -N FUT2.Step1
#$ -l h_vmem=1.0G
#$ -l h_rt=4-00:00:00
#$ -cwd
#$ -o FUT2.Step1.out
#$ -e FUT2.Step1.err
###############################
mkdir $TMPDIR/data
# download the data
tabix -fh ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr19.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 49199228-49209191 | temp.vcf
# remove indels
vcftools --vcf temp.vcf --remove-indels --recode --recode-INFO-all
# 
cat out.recode.vcf| grep -v '##' | cut -f1,2,3,4,5,7,8| awk  '{OFS="\t";  split($7,x,";"); print $1,$2,$3,$4,$5,$6,x[1],x[2],x[3],x[4],x[5],x[6],x[7],x[8],x[9],x[10]}' > fut2.data.txt
# data file called: fut2.data.txt
# copy data to dir
cp fut2.data.txt /home/cvalenc1/FUT2_3_TLR5/
############################
exit



