#!/bin/bash

#wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/assembly_summary.txt

#Change keyword in line below "awk -F "\t" '/<KEYWORD-HERE>/ && ....."
awk -F "\t" '/Bradyrhizobium/ && $12=="Complete Genome" && $11=="latest" {print $8,$9,$20} ' OFS='\t' assembly_summary.txt > tmp.dwnld-pt1.txt

awk 'BEGIN{FS=OFS="/";filesuffix="genomic.fna.gz"}{ftpdir=$0;asm=$10;file=asm"_"filesuffix;print ftpdir,file}' tmp.dwnld-pt1.txt > tmp.dwnld-pt2.txt
sed 's/\ /_/g' tmp.dwnld-pt2.txt > tmp.dwnld-pt2-2.txt
sed 's/strain=//g' tmp.dwnld-pt2-2.txt > tmp.dwnld-pt2-3.txt
paste --delimiter='_' <(cut -f 1 tmp.dwnld-pt2-3.txt) <(cut -f 2 tmp.dwnld-pt2-3.txt) | sed 's/$/.fna.gz -/g' | sed 's/^/wget -O /g' > tmp.dwnld-pt3.txt
paste --delimiter=" " <(cut -f 1 tmp.dwnld-pt3.txt) <(cut -f 3 tmp.dwnld-pt2-3.txt) > Bradyrhizobium_genome_download.sh
rm *dwnld-pt*.txt
