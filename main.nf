#!/usr/bin/env nextflow

/*
========================================================================================
    SAM Analysis Pipeline
    Description: Processes SAM files to calculate MAPQ 60 statistics using Python.
========================================================================================
*/

nextflow.enable.dsl=2

// 1. Parameters
params.input_files = "${projectDir}/*.sam"
params.help = false

// Help message logic
if (params.help) {
    log.info """
    Usage:
      nextflow run main.nf --input_files '/path/to/files/*.sam'

    Options:
      --input_files  Path to SAM files (use quotes if using wildcards).
    """.stripIndent()
    exit 0
}

// 2. Process definition (Modular logic)
process ANALYZE_SAM {
    tag "Processing: ${sam_file.name}"
    
    input:
    path sam_file

    output:
    stdout

    script:
    """
    uv run python main.py ${sam_file}
    """
}

// 3. Workflow execution (Orchestration)
workflow {
    // Create channel from input path
    // Best practice: handle multiple files with fromPath
    sam_ch = Channel.fromPath(params.input_files, checkIfExists: true)

    // Connection: Input channel -> Process -> View output
    ANALYZE_SAM(sam_ch) | view { it.trim() }
}
