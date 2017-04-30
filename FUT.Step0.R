# FUT.Step0.R
# Creating files for each super pop from 1k genome data
## Usage:
# qrsh
# Rscript FUT.Step0.R > FUT.Step0_log.txt 2>&1

# open file
x <- read.table("/home/cvalenc1/1kgenom.pop.csv",header=T, sep=",",row.names=1)
# Create file for East Asia Superpopulation
# select EAS pop: CHB,JPT,CHS,CDX,KHV
temp <- subset(x,population=="CHB",select=sample)
c <- c("JPT","CHS","CDX","KHV")
for (i in c) {
	y <- subset(x, population==i,select=sample)
	temp <- rbind(temp,y)
}
# order:
temp <- as.data.frame(temp[order(temp$sample),])
# print without header. directory will be home directory
write.table(temp,file='EAS.samples',row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')
########
# Create file for South Asia 
# select pop: GIH,PJL,BEB,STU,ITU
temp <- subset(x,population=="GIH",select=sample)
c <- c("PJL","BEB","STU","ITU")
for (i in c) {
	y <- subset(x, population==i,select=sample)
	temp <- rbind(temp,y)
}
# order:
temp <- as.data.frame(temp[order(temp$sample),])
# print without header. directory will be home directory
write.table(temp,file='SAS.samples',row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')
########
# Create file for CEU
temp <- subset(x,population=="CEU",select=sample)
# print without header. directory will be home directory
write.table(temp,file='CEU.samples',row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')

## Reproducibility information
print('Reproducibility information:')
Sys.time()
proc.time()
options(width=120)
session_info()








