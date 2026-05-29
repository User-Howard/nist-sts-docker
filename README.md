# NIST STS Docker

Runs [NIST Statistical Test Suite 2.1.2](https://csrc.nist.gov/projects/random-bit-generation/documentation-and-software) against a binary file.

## Build

```bash
docker build -t nist-sts .
```

## Run

```bash
docker run --rm -v /path/to/file.bin:/input nist-sts <stream_length>
```

`stream_length` is the number of bits to test. Defaults to `1000000`.

**Example: generate a test file and run**

```bash
uv run gen_random.py 1000000
docker run --rm -v $(pwd)/test_random.bin:/input nist-sts 1000000
```

## Save full report

```bash
docker run --rm \
  -v /path/to/file.bin:/input \
  -v $(pwd)/results:/results \
  nist-sts 1000000
```

Output is written to `results/AlgorithmTesting/finalAnalysisReport.txt`.
