#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: ./find_perfect_matches.sh <query file> <subject file> <output file>"
    exit 1
fi

# Assign input arguments to variables
QUERY_FILE=$1
SUBJECT_FILE=$2
OUTPUT_FILE=$3

# Format the subject file into a BLAST database
./makeblastdb -in "$SUBJECT_FILE" -dbtype nucl -out "${SUBJECT_FILE}_db"

# Run BLAST with the necessary options
./blastn -query "$QUERY_FILE" -db "${SUBJECT_FILE}_db" -outfmt 6 -perc_identity 100 > "$OUTPUT_FILE"

# Count the number of perfect matches
MATCH_COUNT=$(wc -l < "$OUTPUT_FILE")

# Print the number of perfect matches
echo "Number of perfect matches: $MATCH_COUNT"
