[![Docker Pulls](https://img.shields.io/docker/pulls/scitran/dwi-split-shells.svg)](https://hub.docker.com/r/scitran/dwi-split-shells/)
[![Docker Stars](https://img.shields.io/docker/stars/scitran/dwi-split-shells.svg)](https://hub.docker.com/r/scitran/dwi-split-shells/)


# scitran/dwi-split-shells
Extract individual diffusion shells from multi-shell DWI data. Output includes a NIfTI, BVEC, and BVAL file for each diffusion shell found in the data.

### Build Docker Image
`docker build -t scitran/dwi-split-shells .`


### Run Locally
Assumes data are in a local directory in the following layout (note the `input` and `output` parent directories):
```.
├── input
│   ├── bval
│   │   └── 101915_dwi.bval
│   ├── bvec
│   │   └── 101915_dwi.bvec
│   └── dwi
│       └── 101915_dwi.nii.gz
├── output
```
Then run the container: 
```
docker run -it --rm \
       -v `pwd`/input:/flywheel/v0/input/ \
       -v `pwd`/output/:/flywheel/v0/output/ \
       scitran/dwi-split-shells
```

For data with 3 diffusion shells (1000, 2000, 3000), the results will be: 
```.
├── input
│   ├── bval
│   │   └── 101915_dwi.bval
│   ├── bvec
│   │   └── 101915_dwi.bvec
│   └── dwi
│       └── 101915_dwi.nii.gz
├── output
│   ├── 101915_dwi_1000.bval
│   ├── 101915_dwi_1000.bvec
│   ├── 101915_dwi_1000.nii.gz
│   ├── 101915_dwi_2000.bval
│   ├── 101915_dwi_2000.bvec
│   ├── 101915_dwi_2000.nii.gz
│   ├── 101915_dwi_3000.bval
│   ├── 101915_dwi_3000.bvec
│   └── 101915_dwi_3000.nii.gz
```
