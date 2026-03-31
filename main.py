#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
=============================================================================
Author: Miriam Belmonte
Date: 2026-03-31

Description:
    Script to analyze a SAM file. It ignores header lines, counts the total 
    number of aligned reads, and calculates how many have a MAPQ of 60.

Usage:
    uv run python main.py <file.sam>

Input:
    Path to a SAM file provided via the terminal.

Output:
    Summary of reads and percentage formatted with colors.

Dependencies:
    - Python 3
    - External library: rich
=============================================================================
"""

import sys
from rich.console import Console

def analyze_sam_alingments(file_path):
    total_reads = 0
    mapq_60_count = 0
    
    with open(file_path, 'r') as f:
        for line in f:
            if line.startswith('@'):
                continue
            
            total_reads += 1
            
            columns = line.split('\t')
            
            if len(columns) > 4:
                quality = columns[4]
                if quality == '60':
                    mapq_60_count += 1
                    
    return total_reads, mapq_60_count

def main():
    if len(sys.argv) != 2:
        print("Error: Missing SAM file.")
        print("Usage: uv run python main.py <file.sam>")
        sys.exit(1)
        
    file_name = sys.argv[1]
    
    total, total_60 = analyze_sam_alingments(file_name)
    
    percentage = (total_60 / total) * 100 if total > 0 else 0.0
    
    console = Console(highlight=False)
    console.print(f"Total of reads aligned: [bold cyan]{total}[/bold cyan]")
    console.print(f"Reads with MAPQ = 60: [bold green]{total_60}[/bold green]")
    console.print(f"Percentage: [bold yellow]{percentage:.1f}%[/bold yellow]")

if __name__ == "__main__":
    main()
