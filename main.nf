#!/usr/bin/env nextflow

/*
========================================================================================
    SAM Analysis Pipeline
    Description: Processes SAM files to calculate MAPQ 60 statistics using Python.
========================================================================================
*/

nextflow.enable.dsl=2

// 1. Parameters
params.input_files = "*.sam"

params.help = false
if (params.help) {
    log.info """
    Usage:
      nextflow run main.nf --input_files '/path/to/files/*.sam'

    Options:
      --input_files  Path to SAM files.
    """
    exit 0
}

// 2. Process
process ANALYZE_SAM {
    tag "Processing: ${sam_file.name}"
    
    input:
    path sam_file

    output:
    stdout

    script:
    "FORCE_COLOR=1 uv run python ${projectDir}/main.py ${sam_file}"
}

// 3. Workflow execution
workflow {
    sam_ch = Channel.fromPath(params.input_files)

    ANALYZE_SAM(sam_ch) | view
}
