class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: fastp
baseCommand:
  - fastp
inputs:
  - id: R1_fastq
    type: File
  - id: R2_fastq
    type: File
outputs:
  - id: R1_trimmed.fastq.gz
    type: File
  - id: R2_trimmed.fastq.gz
    type: File
  - id: fastp_report.json
    type: File
  - id: fastp_report.html
    type: File?
label: fastp
arguments:
  - position: 0
    prefix: '-i'
    valueFrom: R1.fastq.gz
  - position: 0
    prefix: '-I'
    valueFrom: R2.fastq.gz
  - position: 0
    prefix: '-o'
    valueFrom: R1_trimmed.fastq.gz
  - position: 0
    prefix: '-O'
    valueFrom: R2_trimmed.fastq.gz
  - position: 0
    prefix: ''
    valueFrom: '-Q'
  - position: 0
    prefix: ''
    valueFrom: '--umi'
  - position: 0
    prefix: '--umi_loc'
    valueFrom: per_read
  - position: 0
    prefix: '--umi_len'
    valueFrom: '3'
  - position: 0
    prefix: '--umi_prefix'
    valueFrom: UMI
  - position: 0
    prefix: ''
    valueFrom: '--detect_adapter_for_pe'
  - position: 0
    prefix: '--umi_skip'
    valueFrom: '3'
  - position: 0
    prefix: ''
    valueFrom: '-g'
  - position: 0
    prefix: '-W'
    valueFrom: '5'
  - position: 0
    prefix: '-q'
    valueFrom: '20'
  - position: 0
    prefix: '-u'
    valueFrom: '40'
  - position: 0
    prefix: ''
    valueFrom: '-x'
  - position: 0
    prefix: ''
    valueFrom: '-3'
  - position: 0
    prefix: '-l'
    valueFrom: '70'
  - position: 0
    prefix: ''
    valueFrom: '-c'
  - position: 0
    prefix: '-j'
    valueFrom: fastp_report.json
  - position: 0
    prefix: '-h'
    valueFrom: fastp_report.html
requirements:
  - class: ResourceRequirement
    coresMin: 0
  - class: DockerRequirement
    dockerPull: olikodeproktaz/fastp
