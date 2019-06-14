



#Trimming using cutadpt - https://cutadapt.readthedocs.io/en/stable/
cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -u 7 -U 7 -m 40 -q 30 --trim-n -o ./trimmed/UNp62_trimmed_R1.fastq.gz -p ./trimmed/UNp62_trimmed_R2.fastq.gz ./UNP62_CGATGT_L004_R1_001.fastq.gz ./UNP62_CGATGT_L004_R2_001.fastq.gz

cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -u 7 -U 7 -m 40 -q 30 --trim-n -o ./trimmed/pR_trimmed_R1.fastq.gz -p ./trimmed/pR_trimmed_R2.fastq.gz ./PR_TGACCA_L002_R1_001.fastq.gz ./PR_TGACCA_L002_R2_001.fastq.gz

cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -u 7 -U 7 -m 40 -q 30 --trim-n -o ./trimmed/C7p62_trimmed_R1.fastq.gz -p ./trimmed/C7p62_trimmed_R2.fastq.gz ./C7P62_ACAGTG_L001_R1_001.fastq.gz  ./C7P62_ACAGTG_L001_R2_001.fastq.gz

cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -u 7 -U 7 -m 40 -q 30 --trim-n -o ./trimmed/C35_trimmed_R1.fastq.gz -p ./trimmed/C35_trimmed_R2.fastq.gz ./C35_GCCAAT_L003_R1_001.fastq.gz  ./C35_GCCAAT_L003_R2_001.fastq.gz

cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -u 7 -U 7 -m 40 -q 30 --trim-n -o ./trimmed/C35p60_trimmed_R1.fastq.gz -p ./trimmed/C35p60_trimmed_R2.fastq.gz ./C35P60_CAGATC_L002_R1_001.fastq.gz  ./C35P60_CAGATC_L002_R2_001.fastq.gz

cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -u 7 -U 7 -m 40 -q 30 --trim-n -o ./trimmed/pGp32_trimmed_R1.fastq.gz -p ./trimmed/pGp32_trimmed_R2.fastq.gz ./PGP32_CTTGTA_L004_R1_001.fastq.gz  ./PGP32_CTTGTA_L004_R2_001.fastq.gz

cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -u 7 -U 7 -m 40 -q 30 --trim-n -o ./trimmed/C13p27_trimmed_R1.fastq.gz -p ./trimmed/C13p27_trimmed_R2.fastq.gz ./C13P27_AGTCAA_L001_R1_001.fastq.gz  ./C13P27_AGTCAA_L001_R2_001.fastq.gz

cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -u 7 -U 7 -m 40 -q 30 --trim-n -o ./trimmed/C50p30_trimmed_R1.fastq.gz -p ./trimmed/C50p30_trimmed_R2.fastq.gz ./C50P30_AGTTCC_L003_R1_001.fastq.gz  ./C50P30_AGTTCC_L003_R2_001.fastq.gz




#MAPPING using bismark - https://www.bioinformatics.babraham.ac.uk/projects/bismark/

/home/gatto/Selig_collaboration/bismark_v0.14.5/bismark -p 4 -q -chunkmbs 200 -o ./trimmed/mappingBismark/ --sam -B pR_G4L__X1000_I0___L-0-06_trim_hg38 ./hg38_genome/ -1 ./trimmed/pR_trimmed_R1.fastq.gz -2 ./trimmed/pR_trimmed_R2.fastq.gz --score_min L,0,-0.6 -X 1000 -I 0

/home/gatto/Selig_collaboration/bismark_v0.14.5/bismark -p 4 -q -chunkmbs 200 -o ./trimmed/mappingBismark/ --sam -B UNp62_G4L__X1000_I0___L-0-06_trim_hg38 ./hg38_genome/ -1 ./trimmed/UNp62_trimmed_R1.fastq.gz -2 ./trimmed/UNp62_trimmed_R2.fastq.gz --score_min L,0,-0.6 -X 1000 -I 0

/home/gatto/Selig_collaboration/bismark_v0.14.5/bismark -p 4 -q -chunkmbs 200 -o ./trimmed/mappingBismark/ --sam -B C7p62_G4L__X1000_I0___L-0-06_trim_hg38 ./hg38_genome/ -1 ./trimmed/C7p62_trimmed_R1.fastq.gz -2 ./trimmed/C7p62_trimmed_R2.fastq.gz --score_min L,0,-0.6 -X 1000 -I 0

nohup /home/gatto/Selig_collaboration/bismark_v0.14.5/bismark -p 4 -q -chunkmbs 200 -o ./trimmed/mappingBismark/ --sam -B C35_G4L__X1000_I0___L-0-06_trim_hg38 ./hg38_genome/ -1 ./trimmed/C35_trimmed_R1.fastq.gz -2 ./trimmed/C35_trimmed_R2.fastq.gz --score_min L,0,-0.6 -X 1000 -I 0 &

nohup /home/gatto/Selig_collaboration/bismark_v0.14.5/bismark -p 4 -q -chunkmbs 200 -o ./trimmed/mappingBismark/ --sam -B C35p60_G4L__X1000_I0___L-0-06_trim_hg38 ./hg38_genome/ -1 ./trimmed/C35p60_trimmed_R1.fastq.gz -2 ./trimmed/C35p60_trimmed_R2.fastq.gz --score_min L,0,-0.6 -X 1000 -I 0 &

nohup /home/gatto/Selig_collaboration/bismark_v0.14.5/bismark -p 4 -q -chunkmbs 200 -o ./trimmed/mappingBismark/ --sam -B pGp32_G4L__X1000_I0___L-0-06_trim_hg38 ./hg38_genome/ -1 ./trimmed/pGp32_trimmed_R1.fastq.gz -2 ./trimmed/pGp32_trimmed_R2.fastq.gz --score_min L,0,-0.6 -X 1000 -I 0 &

nohup /home/gatto/Selig_collaboration/bismark_v0.14.5/bismark -p 4 -q -chunkmbs 200 -o ./trimmed/mappingBismark/ --sam -B C13p27_G4L__X1000_I0___L-0-06_trim_hg38 ./hg38_genome/ -1 ./trimmed/C13p27_trimmed_R1.fastq.gz -2 ./trimmed/C13p27_trimmed_R2.fastq.gz --score_min L,0,-0.6 -X 1000 -I 0 &

nohup /home/gatto/Selig_collaboration/bismark_v0.14.5/bismark -p 4 -q -chunkmbs 200 -o ./trimmed/mappingBismark/ --sam -B C50p30_G4L__X1000_I0___L-0-06_trim_hg38 ./hg38_genome/ -1 ./trimmed/C50p30_trimmed_R1.fastq.gz -2 ./trimmed/C50p30_trimmed_R2.fastq.gz --score_min L,0,-0.6 -X 1000 -I 0 &








#Methylaton extraction - using bismark_methylation_extractor (included in the bismark project - https://github.com/FelixKrueger/Bismark/blob/master/bismark_methylation_extractor)

nohup bismark_methylation_extractor -p --no_overlap --report --bedGraph --counts --buffer_size 10G --cytosine_report --genome_folder ./hg38_genome/  ./trimmed/mappingBismark/UNp62_G4L__X1000_I0___L-0-06_trim_hg38_pe.sam &

nohup bismark_methylation_extractor -p --no_overlap --report --bedGraph --counts --buffer_size 10G --cytosine_report --genome_folder ./hg38_genome/  ./trimmed/mappingBismark/pR_G4L__X1000_I0___L-0-06_trim_hg38_pe.sam &

nohup bismark_methylation_extractor -p --no_overlap --report --bedGraph --counts --buffer_size 10G --cytosine_report --genome_folder ./hg38_genome/  ./trimmed/mappingBismark/C7p62_G4L__X1000_I0___L-0-06 &

nohup bismark_methylation_extractor -p --no_overlap --report --bedGraph --counts --buffer_size 10G --cytosine_report --genome_folder ./hg38_genome/  ./trimmed/mappingBismark/C35_G4L__X1000_I0___L-0-06_trim_hg38_pe.sam &

nohup bismark_methylation_extractor -p --no_overlap --report --bedGraph --counts --buffer_size 10G --cytosine_report --genome_folder ./hg38_genome/  ./trimmed/mappingBismark/C35p60_G4L__X1000_I0___L-0-06_trim_hg38_pe.sam &

nohup bismark_methylation_extractor -p --no_overlap --report --bedGraph --counts --buffer_size 10G --cytosine_report --genome_folder ./hg38_genome/  ./trimmed/mappingBismark/pGP32_G4L__X1000_I0___L-0-06_trim_hg38_pe.sam &

nohup bismark_methylation_extractor -p --no_overlap --report --bedGraph --counts --buffer_size 10G --cytosine_report --genome_folder ./hg38_genome/  ./trimmed/mappingBismark/C13p27_G4L__X1000_I0___L-0-06_trim_hg38_pe.CpG_report.txt &

nohup bismark_methylation_extractor -p --no_overlap --report --bedGraph --counts --buffer_size 10G --cytosine_report --genome_folder ./hg38_genome/  ./trimmed/mappingBismark/C50p30_G4L__X1000_I0___L-0-06_trim_hg38_pe.CpG_report.txt &




