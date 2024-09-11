class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gencore
baseCommand:
  - gencore
inputs:
  - id: sort.bam
    type: File
  - id: hg38
    type: File
  - id: bed_file
    type: File
outputs:
  - id: umi_merged.bam
    type: File?
  - id: report.html
    type: File?
label: gencore
arguments:
  - position: 0
    prefix: '-i'
    valueFrom: sort.bam
  - position: 0
    prefix: '-o'
    valueFrom: umi_merged.bam
  - position: 0
    prefix: '-r'
    valueFrom: hg38
  - position: 0
    prefix: '-s'
    valueFrom: '2'
  - position: 0
    prefix: '-b'
    valueFrom: bed_file
  - position: 0
    prefix: '--umi_diff_threshold'
    valueFrom: '1'
  - position: 0
    prefix: '--html'
    valueFrom: report.html
requirements:
  - class: DockerRequirement
    dockerPull: olikodeproktaz/gencore
