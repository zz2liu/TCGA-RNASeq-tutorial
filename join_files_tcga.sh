# usage example: bash PROG > geneId_fileId_RPKM.txt
# paste the 2nd column of each file into a matrix of featureId x fileId
# run from the directory with the result of 'gdc-client download -m'
files=*/*.gz
for f in $files; do
    dirname $f > $f.tmp #file_id
    zcat $f | cut -f2 >> $f.tmp
done
#compile together with index column
echo 'featureId' > tmp.tmp
zcat $f | cut -f1 >> tmp.tmp
paste tmp.tmp $files.tmp
rm tmp.tmp $files.tmp
