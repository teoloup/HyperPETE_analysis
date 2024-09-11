class: Workflow
cwlVersion: v1.0
id: hyperpete_pipeline
label: HyperPETE_pipeline
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: R2_fastq
    type: File
    'sbg:x': 0
    'sbg:y': 121
  - id: R1_fastq
    type: File
    'sbg:x': 0
    'sbg:y': 228
  - id: hg38.fasta
    type: File
    'sbg:x': 0
    'sbg:y': -84.54663848876953
  - id: targets_file.bed
    type: File
    'sbg:x': 828.4165649414062
    'sbg:y': 335.41259765625
  - id: annovar_dbs
    type: Directory
    'sbg:x': 1959.666015625
    'sbg:y': 67.5
outputs:
  - id: fastp_report.html
    outputSource:
      - fastp/fastp_report.html
    type: File?
    'sbg:x': 415.75244140625
    'sbg:y': 107
  - id: fastp_report.json
    outputSource:
      - fastp/fastp_report.json
    type: File
    'sbg:x': 415.75244140625
    'sbg:y': 0
  - id: report.html
    outputSource:
      - gencore/report.html
    type: File?
    'sbg:x': 1281.0091552734375
    'sbg:y': 5.833122253417969
steps:
  - id: fastp
    in:
      - id: R1_fastq
        source: R1_fastq
      - id: R2_fastq
        source: R2_fastq
    out:
      - id: R1_trimmed.fastq.gz
      - id: R2_trimmed.fastq.gz
      - id: fastp_report.json
      - id: fastp_report.html
    run: ./fastp.cwl
    label: fastp
    'sbg:x': 131.3125
    'sbg:y': 100
  - id: bwa_mem_0_7_15
    in:
      - id: fastq1
        source: fastp/R1_trimmed.fastq.gz
      - id: fastq2
        source: fastp/R2_trimmed.fastq.gz
      - id: ref_seq
        source: hg38.fasta
    out:
      - id: output_sam
    run: ./bwa_mem.cwl
    label: bwa mem v0.7.5
    'sbg:x': 415.75244140625
    'sbg:y': 228
  - id: samtools_view__sb
    in:
      - id: aligned_sam
        source: bwa_mem_0_7_15/output_sam
    out:
      - id: aligned_bam
    run: ./samtools_view_sb.cwl
    label: samtools_view_Sb
    'sbg:x': 632.00244140625
    'sbg:y': 121
  - id: samtools_sort
    in:
      - id: aligned_bam
        source: samtools_view__sb/aligned_bam
    out:
      - id: sorted
    run: ./samtools_sort.cwl
    label: samtools_sort
    'sbg:x': 859.58056640625
    'sbg:y': 67.5
  - id: samtools_index_bam
    in:
      - id: bam_file
        source: samtools_sort/sorted
    out: []
    run: ./samtools_index_bam.cwl
    label: samtools_index_bam
    'sbg:x': 1053.58056640625
    'sbg:y': 53.5
  - id: gencore
    in:
      - id: sort.bam
        source: samtools_sort/sorted
      - id: hg38
        source: hg38.fasta
      - id: bed_file
        source: targets_file.bed
    out:
      - id: umi_merged.bam
      - id: report.html
    run: ./gencore.cwl
    label: gencore
    'sbg:x': 1053.58056640625
    'sbg:y': 174.5
  - id: picard_addorreplacereadgroups
    in:
      - id: sorted_dedup_bam
        source: gencore/umi_merged.bam
    out:
      - id: dedup_RG_bam
    run: ./picard_addorreplacereadgroups.cwl
    label: picard_AddOrReplaceReadGroups
    'sbg:x': 1298.967529296875
    'sbg:y': 174.5
  - id: gatk_mutect2_tumoronly
    in:
      - id: ref_fasta
        source: hg38.fasta
      - id: bam
        source: picard_addorreplacereadgroups/dedup_RG_bam
      - id: bed_file
        source: targets_file.bed
    out:
      - id: vcf
    run: ./gatk_mutect2_tumoronly.cwl
    label: gatk_Mutect2_tumorOnly
    'sbg:x': 1579.889404296875
    'sbg:y': 107
  - id: gatk_filtermutectcalls
    in:
      - id: ref_file
        source: hg38.fasta
      - id: vcf_file
        source: gatk_mutect2_tumoronly/vcf
    out:
      - id: filtered_vcf
    run: ./gatk_filtermutectcalls.cwl
    label: gatk_FilterMutectCalls
    'sbg:x': 1759.545654296875
    'sbg:y': 114
  - id: annovar_table_annovar_pl
    in:
      - id: Convert_2_Annovar.avinput
        source: annovar_convert2annovar/Convert_2_Annovar.avinput
      - id: annovar_dbs
        source: annovar_dbs
    out:
      - id: annotated.vcf
    run: ./annovar_table_annovar-pl.cwl
    label: annovar_table_annovar.pl
    'sbg:x': 2268.728515625
    'sbg:y': 114
  - id: annovar_convert2annovar
    in:
      - id: filtered.vcf.gz
        source: gatk_filtermutectcalls/filtered_vcf
    out:
      - id: Convert_2_Annovar.avinput
    run: ./annovar_convert2annovar.cwl
    label: Annovar_convert2annovar
    'sbg:x': 1959.666015625
    'sbg:y': 174.5
requirements: []
