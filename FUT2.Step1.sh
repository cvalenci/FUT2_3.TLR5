#!/bin/bash
#$ -N FUT2.Step1
#$ -l h_vmem=1.0G
#$ -l h_rt=5000
#$ -cwd
#$ -o FUT2.Step1.out
#$ -e FUT2.Step1.err
###############################
mkdir -p ~/FUT2
cd ~/FUT2
# download the data
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr19.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 
# remove indels and select region
vcftools --gzvcf ALL.chr19.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz --remove-indels --chr 19 --from-bp 49199228 --to-bp 49209191 --recode --recode-INFO-all
# make allele freq data for all pop. 
cat out.recode.vcf| grep -v '##' | cut -f1,2,3,4,5,7,8| awk  '{OFS="\t";  split($7,x,";"); print $1,$2,$3,$4,$5,$6,x[1],x[2],x[3],x[4],x[5],x[6],x[7],x[8],x[9],x[10]}' > fut2.Allele.data.txt
# data file called: fut2.Allele.data.txt
### Create vcf for population and get the LD statistics
# EAS
vcftools --vcf out.recode.vcf --keep /home/cvalenc1/EAS.samples --recode --out temp| vcftools --vcf temp.recode.vcf --hap-r2 --out LD.EAS.FUT2

# SAS
vcftools --vcf out.recode.vcf --keep /home/cvalenc1/SAS.samples --recode --out temp| vcftools --vcf temp.recode.vcf --hap-r2 --out LD.SAS.FUT2

# CEU
vcftools --vcf out.recode.vcf --keep /home/cvalenc1/CEU.samples --recode --out temp| vcftools --vcf temp.recode.vcf --hap-r2 --out LD.CEU.FUT2

# remove files:
rm ALL.chr19.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 
############################
exit



