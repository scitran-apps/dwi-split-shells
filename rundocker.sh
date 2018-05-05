docker run -it --rm \
       -v `pwd`/local/testdata/:/flywheel/v0/input/ \
       -v `pwd`/local/output/:/flywheel/v0/output/ \
       scitran/dwi-split-shells
