# NGS of A2KRAS02 mutant library CDR3 region after stimulation with peptides or cell lines

ml FastQC
ml SAMtools
ml BCFtools
ml Trim_Galore
ml PEAR
ml Bowtie2
ml RTCR

cd /fh/fast/greenberg_p/user/jwlee/ngs_processing/210920_M03100_0718_000000000-K35RC/
projPath="../../../../SR/ngs/illumina/tschmitt/210920_M03100_0718_000000000-K35RC"
outPath="."

# Quality control using FastQC
# As written, this also processes the Ix (index) FASTQ files, which
# is unnecessary here
mkdir -p $outPath/fastqFileQC
for file in ${projPath}/Data/Intensities/BaseCalls/*.fastq.gz
do
    fastqc -o $outPath/fastqFileQC -f fastq $file
done

# hg38 bowtie build has already been built

mkdir -p $outPath/trimmed
mkdir -p $outPath/merged
for R1file in `find $projPath/Data/Intensities/BaseCalls/*_R1_*`
do
    fileNameOnly=${R1file%.*.*} # Remove extension from file name
    fileNameOnly=`basename ${fileNameOnly//_L001_R1_001/}`
    R2file=${R1file//R1/R2} # Paired read 2
    # Trim adapter sequences since we have PE150
    trim_galore --paired --phred33 --cores 10 -o ${outPath}/trimmed $R1file $R2file \
        2> $outPath/trimmed/${fileNameOnly}_trim_galore.log

    # Use PEAR to merge the paired-end reads for each sample
    pear -f $outPath/trimmed/${fileNameOnly}_L001_R1_001_val_1.fq.gz -r $outPath/trimmed/${fileNameOnly}_L001_R2_001_val_2.fq.gz \
        -o $outPath/merged/${fileNameOnly}_R1_R2_merged.fastq -j 10
done

# Reference sequence is the unmodified A2KRAS02 TCR sequence
bowtie2-build $outPath/KRS#2LibraryFragWT.fasta KRAS2_reference/KRAS2_reference 

# Use RTCR to find TCR sequences
files=`find $outPath/merged/*.assembled.fastq`
mkdir -p ${outPath}/alignment/bam ${outPath}/alignment/sam ${outPath}/alignment/vcf
for file in $files
do
    fileNameOnly=${file%.*.*.*} # Remove extension from file name
    fileNameOnly=`basename ${fileNameOnly//_R1_R2_merged/}`
   
    # Mapping
    bowtie2 -x KRAS2_reference/KRAS2_reference -U $file --no-unal -S ${outPath}/alignment/sam/${fileNameOnly}.sam --threads 10

    # sort sam and convert to bam
    samtools view -bS ${outPath}/alignment/sam/${fileNameOnly}.sam | samtools sort -o ${outPath}/alignment/bam/${fileNameOnly}.bam

    # Convert bam to fastas
    samtools fastq ${outPath}/alignment/bam/${fileNameOnly}.bam -F 4 --threads 10 > ${outPath}/alignment/bam/${fileNameOnly}.fastq
    # Get variants
    #bcftools mpileup ${outPath}/alignment/bam/${fileNameOnly}.bam -o ${outPath}/alignment/vcf/${fileNameOnly}.vcf.gz -O z --threads 10 \
    #    -f $outPath/KRS#2LibraryFragWT.fasta

    # Call variants
    #bcftools call ${outPath}/alignment/vcf/${fileNameOnly}.vcf.gz -o ${outPath}/alignment/vcf/${fileNameOnly}_calls.vcf.gz -O z --threads 10 \
    #    -m --ploidy 1

    #bcftools mpileup -Ou -f KRS#2LibraryFragWT.fasta ${outPath}/alignment/bam/${fileNameOnly}.bam --max-depth 10000000 --threads 10 \
    #    | bcftools call -mv -Ov -o ${outPath}/alignment/vcf/${fileNameOnly}_calls.vcf --threads 10 --ploidy 1
   # these reads have alraedy been demuxed so not running the barcoded protocol
   # running non-barcoded protocol
done