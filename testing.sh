# testing
mkdir -p test
cd test/
# get the smallest vcf file and take a look at the info fields
wget --timestamping ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
#
wget --timestamping ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz.tbi 
# print some lines to see the info fields in the vcf file:
gzip -cd ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz | sed '1,1000d'|more
# line for 1 variant:
# we have info for:
# AC: allele counts in genotypes, for each alternative allele
# AF: global freq of alternative allele. so = AC/AN
# AN: total number of alleles in called genotypes
# NS: numb samples with data
# allele freq for super-pop: Eas-Asia (EAS_AF),South.Asian (SAS_AF), European (EUR_AF)....
#22	16112935	rs546390909	T	G	100	PASS	AC=2;AF=0.000399361;AN=5008;NS=2504;DP=22210;EAS_AF=0;AMR_AF=0;AFR_AF=
#0.0015;EUR_AF=0;SAS_AF=0;AA=T|||;VT=SNP	GT

# First we can filter by chromosome and position and print only the info field for each variant.
# I want fiels: from 1 - 8, then split field $8
vcftools --gzvcf ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz --remove-indels --chr 22 --from-bp 16112935 --to-bp 16275195 --recode --recode-INFO-all
#
#cat out.recode.vcf| grep -v '##' | cut -f1,2,3,4,5,7,8| awk  '{OFS="\t";  split($7,x,";"); split(x[1],y,"="); print $1,$2,$3,$4,$5,$6, y[2]}' > temp2.txt
# This code works to split the INFO field by ';' created a txt file, then I can split specific columns in R
cat out.recode.vcf| grep -v '##' | cut -f1,2,3,4,5,7,8| awk  '{OFS="\t";  split($7,x,";"); print $1,$2,$3,$4,$5,$6,x[1],x[2],x[3],x[4],x[5],x[6],x[7],x[8],x[9],x[10]}' > temp2.txt
########################
# Once we have the data we can work in R.
# open file in R
x <- read.table('temp2.txt', header=F)
# add name to columns
colnames(x) <- c("chr","position","id","ref","alt","qual","AC","AF","AN","V10","V11","V12","V13","V14","V15","V16")
# split variable of interest, 



tabix -fh ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 16112935-16275195| grep -v '##' | awk '{print $1,$2,$3,$4,$5,$6,$7,$8}' > test.txt

tabix -fh ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 16112935-16275195 | grep -v '##' | awk '{print $1,$2,$3,$4,$5,$6,$7,$8}' > test.txt

tabix -fh ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 16112935-16275195 | grep -v '##' | cut -f 1,2,3,4,5,6,7,8 > temp.vcf

tabix -fh ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 16112935-16275195 | 

vcftools --gzvcf ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz --chr 22 --from-bp 16112935 --to-bp 16275195 --recode --recode-INFO-all

gzip ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz | grep -v '##' | awk '{print $1,$2,$3}' > temp.txt


