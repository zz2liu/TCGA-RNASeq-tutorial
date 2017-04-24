raw = read.delim('geneId_fileId.FPKM.txt', row.names=1, check.names=F)
#head(raw)
fileInfo = read.csv('fileInfo.csv', row.names=1)
geneInfo = read.csv('gencode_v22_geneInfo.csv', row.names=1)
geneInfo = geneInfo[rownames(raw),]
fileInfo = fileInfo[colnames(raw),]
colnames(raw) = fileInfo$barcode
rownames(raw) = paste(geneInfo$gene_name, rownames(raw), sep='|')
write.csv(raw, 'FPKM.csv')
