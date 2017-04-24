# TCGA-RNASeq-tutorial
The tutorial for a yale training session: TCGA RNA-seq Data, Download and Analyses all on your laptop.

## Go to [TCGA data hub](https://portal.gdc.cancer.gov/)
- Navigate and select files to basket
- Download metadata and manifest from basket
- Download the files with [GDC-client]()

## Preprocess the metadata
- Convert to csv use the online tool()
- [Description here](http://docs.cancergenomicscloud.org/docs/tcga-metadata)
- Choose and rename fields in a speadsheet or a [R script](preprocess_metadata.R)

## Preprocess the FPKM matrix
- Convert the downloaded files to a FPKM matrix in unix shell/terminal
```
for f in */*.gz; do
  id=$(dirname $f); echo $id > $id.tmp; 
  zcat $f | cut -f2 >> $id.tmp; 
done
echo 'featureId' > tmp.index
zcat $f | cut -f1 >> tmp.index
paste tmp.index *.tmp > ../geneId_fileId_RPKM.txt
rm tmp.index; rm *.tmp

```
- [Description of the Barcode](https://wiki.nci.nih.gov/display/TCGA/TCGA+barcode)
- Download [the GENCODE gene annotation file](gencode_v24_geneInfo.csv)
- Map the FPKM matrix to gene symbol and barcode in R

```
write.csv
```

## Introduction of analyses in R
- Filter the genes and convert FPKM to log scale
```
```

- sample distance
- PCA
- Id genes coexpressed with your gene of interest
- Id genes differently expressed between paired normal and tumor
- survival analysis of a gene hi/low with survival, multivariate

## Introduction of the analyses by FireHose
- Gene
- Cohort summary
- Cohort data
- Cohort analysis
