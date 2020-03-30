#!/bin/bash

#wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/assembly_summary.txt
#awk -F "\t" '/Bradyrhizobium/ && $12=="Complete Genome" && $11=="latest" {print $8,$9,$20} ' OFS='\t' assembly_summary.txt > ftpdir.txt

#awk -F "\t" '/Xanthomonas/ && $12=="Complete Genome" && $11=="latest" {print $20} ' OFS='\t' assembly_summary.txt > ftpdir.txt
#awk 'BEGIN{FS=OFS="/";filesuffix="genomic.fna.gz"}{ftpdir=$0;asm=$10;file=asm"_"filesuffix;print ftpdir,file}' ftpdirpaths > ftpfilepaths

awk -F "\t" '/Bradyrhizobium/ && $12=="Complete Genome" && $11=="latest" {print $8,$9,$20} ' OFS='\t' assembly_summary.txt > Xanth.dwnld-pt1.txt
awk 'BEGIN{FS=OFS="/";filesuffix="genomic.fna.gz"}{ftpdir=$0;asm=$10;file=asm"_"filesuffix;print ftpdir,file}' Xanth.dwnld-pt1.txt > Xanth.dwnld-pt2.txt
sed 's/\ /_/g' Xanth.dwnld-pt2.txt > Xanth.dwnld-pt2-2.txt
sed 's/strain=//g' Xanth.dwnld-pt2-2.txt > Xanth.dwnld-pt2-3.txt
paste --delimiter='_' <(cut -f 1 Xanth.dwnld-pt2-3.txt) <(cut -f 2 Xanth.dwnld-pt2-3.txt) | sed 's/$/.fna.gz -/g' | sed 's/^/wget -O /g' > Xanth.dwnld-pt3.txt
paste --delimiter=" " <(cut -f 1 Xanth.dwnld-pt3.txt) <(cut -f 3 Xanth.dwnld-pt2-3.txt) > Bradyrhizobium_genome_download.sh
rm *dwnld-pt*.txt
