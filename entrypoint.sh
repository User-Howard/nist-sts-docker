#!/bin/sh

STREAM_LENGTH="${1:-1000000}"
INPUT_FILE="${2:-/input}"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: input file not found: $INPUT_FILE"
    echo ""
    echo "Usage:"
    echo "  docker run --rm -v /path/to/file.bin:/input nist-sts [stream_length]"
    echo "  docker run --rm -v /path/to/file.bin:/data/file.bin nist-sts [stream_length] /data/file.bin"
    exit 1
fi

mkdir -p /results/AlgorithmTesting
for test in Frequency BlockFrequency Runs LongestRun Rank FFT \
            NonOverlappingTemplate OverlappingTemplate Universal \
            LinearComplexity Serial ApproximateEntropy CumulativeSums \
            RandomExcursions RandomExcursionsVariant; do
    mkdir -p "/results/AlgorithmTesting/$test"
done

ln -sfn /results /nist/experiments

# stdin answers:
#   0  -> Input File
#   $INPUT_FILE -> filename
#   1  -> run all 15 tests
#   0  -> keep default parameters
#   1  -> 1 bitstream
#   1  -> Binary format
printf "0\n%s\n1\n0\n1\n1\n" "$INPUT_FILE" | /nist/assess "$STREAM_LENGTH"

echo ""
echo "=== Final Analysis Report ==="
cat /results/AlgorithmTesting/finalAnalysisReport.txt
