#read count matrix and map to geneName and barcode
raw = read.delim('geneId_fileId_FPKM.txt', row.names=1, check.names=F)
fileInfo = read.csv('fileInfo.csv', row.names=1)
geneInfo = read.csv('gencode_v22_geneInfo.csv', row.names=1)
geneInfo = geneInfo[rownames(raw),]
fileInfo = fileInfo[colnames(raw),]
colnames(raw) = fileInfo$barcode
rownames(raw) = paste(geneInfo$gene_name, rownames(raw), sep='|')

#convert to log scale and filter by max count of a gene
logFpkm = log2(as.matrix(raw)+1)
remove(raw)
tmp = apply(logFpkm, 1, max)
plot(density(tmp))
plot(density(tmp[tmp<2]))
sele = tmp>=1
logFpkm = logFpkm[sele,]
geneInfo = geneInfo[sele,]

#Give a gene, boxplot against fileInfo
grep('GATA6', rownames(logFpkm), value=T)
i = 'GATA6|ENSG00000141448.7' 
x = logFpkm[i,]
colnames(fileInfo)
table(fileInfo$samples.sample_type)
boxplot(x~fileInfo$samples.sample_type)
boxplot(x~fileInfo$tumor_stage, las=2)

#paired tumor-normal test
norInfo = fileInfo[fileInfo$samples.sample_type=='Solid Tissue Normal',]
priInfo = fileInfo[fileInfo$samples.sample_type=='Primary Tumor',]
norBarcodes = as.character(norInfo$barcode)
sele = match(norInfo$case_id, priInfo$case_id)
priBarcodes = as.character(priInfo$barcode[sele])
boxplot(cbind(pri=x[priBarcodes], nor=x[norBarcodes]))
t.test(x[priBarcodes], x[norBarcodes], paired=T)

#find most correlated genes
tmp = cor(x, t(logFpkm))
res = sort(tmp[1,])
write.csv(res, 'geneCorr.GATA6.csv')
head(res)
tail(res)
plot(res)

#PCA plot
tmp = princomp(logFpkm)
plot(tmp)
plot(tmp$loadings[,1:2])
plot(tmp$loadings[,1:2], col=fileInfo$samples.sample_type)
colnames(fileInfo)
plot(tmp$loadings[,1:2], col=fileInfo$tumor_stage)
plot(tmp$loadings[,1:2], col=fileInfo$race)
identify(tmp$loadings[,1:2], fileInfo$barcode)

#Heatmap

#Differential Expression between tumor and paired-normal

#survival analysis of a gene hi/low with survival, multivariate
