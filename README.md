
[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.0-green.svg)](https://github.com/soichih/abcd-spec)

# app-splitshells
still need to edit: clean.sh, package.json

<<<<<<< HEAD
# Running via Docker

You can run this app anywhere that has docker engine installed.

## Build docker container

If you are not going to use the one that we've published on docker hub, you can build the container locally by git cloning this repo, and then run following command

`docker build -t app-splitshell .`

## Create config.json
=======
## Running via Docker

You can run this app anywhere that has docker engine installed.

### Build docker container

If you are not going to use the one that we've published on docker hub, you can build the container locally by git cloning this repo, and then run following command

`docker<<<<<<< master build -t app-splitshells .`

### Create config.json
>>>>>>> 6c61a889f984d29df7da0b3e68e28be2d9eebfe6

This container receives input parameter via config.json. Create something like following in your current working directory.

```
{
        "shell": 2000,
        "bvals": "/input/dwi.bvals",
        "bvecs": "/input/dwi.bvecs",
        "dwi": "/input/dwi.nii.gz"
}
```

/input is a path inside the container which we will map from our host directory. In this example, I will create a directory called testdata in my working directory.

```
mkdir testdata
# copy your dwi.bvals, dwi.bvecs, and dwi.nii.gz in to testdata
```
## Running container

Now, run docker run to run the app

```
docker run -it --rm \
    -v `pwd`/testdata:/input \
    -v `pwd`:/output \
    brainlife/splitshells

```

We will volume mount (-v) current working directory's testdata directory as container's /input directory, and also the current working directory as container's /output directory. /output directory is used as the working directory inside the container (which is mounted from the host's current working directory). So, by placing the config.json on the host's current working directory, container will find config.json under its /output directory. 

