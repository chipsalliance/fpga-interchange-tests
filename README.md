# FPGA interchange tests

This repository contains end-to-end tests to verify the correctness of the whole FPGA interchange flow.

## Steps to run

To prepare the environment run:

```
make env
```

Enter the environment by running:

```
make enter
```

To build the CMake infrastructure and the required tools run:

```
make build
```

A set of targets are generated to run every step of the flow:

```
cd build
# Run all place and route tests until bitstream generation
make all-tests
# Run all validation tests through fasm2bels
make all-validation-tests
# Run all vendor bitstream generation tests
make all-vendor-bit-tests
# Run all simulation tests; pre- and post-synthesis and, if enabled, post-fasm2bels
make all-simulation-tests
```
