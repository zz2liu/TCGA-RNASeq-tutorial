# TCGA-RNASeq-tutorial
The tutorial for a yale training session: TCGA RNA-seq Data, Download and Analyses all on your laptop.

See the [slides used during the workshop here](https://docs.google.com/presentation/d/1VsaNRqIvSCh6-opNoEZOqwdp6k601njxjY_rK7eW6S0/edit?usp=sharing).

## Go to [TCGA data hub](https://portal.gdc.cancer.gov/)
- Navigate and select files to basket
- Download metadata and manifest from basket
- Download the files with [GDC-client](https://gdc.cancer.gov/access-data/gdc-data-transfer-tool)

## Preprocess the metadata
- Convert to csv use the [online tool json-to-csv](http://www.convertcsv.com/json-to-csv.htm)
- [Metadata Description here](http://docs.cancergenomicscloud.org/docs/tcga-metadata)
- Choose and rename fields in a speadsheet or a [R script](preprocess_metadata.R). 

.. Note: To to run the R script, you can install [Rstudio](http://www.rstudio.com).

## Preprocess the FPKM matrix
- Convert the downloaded files to a FPKM matrix in *unix shell/terminal*
```bash
for f in */*.gz; do
  id=$(dirname $f); echo $id > $id.tmp; 
  zcat $f | cut -f2 >> $id.tmp; 
done
echo 'featureId' > tmp.index
zcat $f | cut -f1 >> tmp.index
paste tmp.index *.tmp > ../geneId_fileId_FPKM.txt
rm tmp.index; rm *.tmp
```
.. Note: to use linux shell, run `terminal` on mac (OS X); install and run [babun]( http://babun.github.io/) on a PC (windows). 

- [Description of the Barcode](https://wiki.nci.nih.gov/display/TCGA/TCGA+barcode)
- [Description of the pipeline](https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/)
- Download [the GENCODE gene annotation file](gencode_v22_geneInfo.csv)
- Map the FPKM matrix to gene symbol and barcode with [preprocess_count_matrix.R](preprocess_count_matrix.R).

## Introduction of analyses in R
[Using the script](introduction_to_analyses.R) to:
- Filter the genes and convert FPKM to log scale
- Id genes coexpressed with your gene of interest
- Id genes differently expressed between paired normal and tumor
- PCA plot

## Introduction of the analyses by FireHose
- Gene
- Cohort summary
- Cohort data and workflow
- Cohort analysis
