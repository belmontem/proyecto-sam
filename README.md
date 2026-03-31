# SAM Quality Analysis Pipeline

This project is a bioinformatics pipeline developed to automate the quality analysis of alignment files in **SAM** format. It uses **Nextflow** for workflow orchestration and **Python** for the data processing logic.

## Project Description

The program processes SAM files to calculate critical alignment statistics:
- Total count of aligned reads.
- Identification of reads with maximum mapping quality (MAPQ = 60).
- Calculation of the percentage of high-quality reads out of the total.

## System Requirements

To run this pipeline, you need to have the following installed:
- Java 11 or higher (required for Nextflow).
- Nextflow: For workflow management.
- uv: For Python dependency and environment management.

## File Structure

- `main.nf`: Nextflow script (DSL2) that coordinates the execution.
- `main.py`: Python script that performs the filtering and metric calculations.
- `pyproject.toml`: Environment configuration and dependencies (`rich` library).
- `WT.sam`: Example file for testing purposes.
- `.git/`: Project version control history.

## Usage Instructions

1. Default execution:
By default, the pipeline will search for any `.sam`files in the current directory.

2. Pipeline execution:
   Run the following command in your terminal:
   ```bash
   nextflow run main.nf

3. Custom input files:
You can specify a different file or directory using the --sam parameter
    ```bash
    nextflow run main.nf --sam 'path/to/your/files/*.sam'

4. Help menu
To display the built-in help message with the available options without running the analysis, run the --hept flag:
    ```bash
    nextflow run main.nf --help 
