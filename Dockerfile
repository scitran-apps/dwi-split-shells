FROM flywheel/matlab-mcr:v93

MAINTAINER Garikoitz Lerma-Usabiaga <glerma@stanford.edu>


# Make directory for flywheel spec (v0)
ENV FLYWHEEL /flywheel/v0
RUN mkdir -p ${FLYWHEEL}
COPY manifest.json ${FLYWHEEL}/manifest.json
ADD /msa /msa

# Run script
COPY run ${FLYWHEEL}/run
RUN chmod +x ${FLYWHEEL}/run

# Configure entrypoints-
ENTRYPOINT ["/flywheel/v0/run"]

