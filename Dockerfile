FROM debian:buster-slim

# Inform-7 requires Perl
RUN apt-get -y update && \
    apt-get -y install \
        perl \
        uuid-runtime

# Install Inform-7 from our copy
WORKDIR /root/in
ADD files/I7_6M62_Linux_all.tar.gz ./
WORKDIR /root/in/inform7-6M62
RUN ./install-inform7.sh && \
    cd ../.. && \
    rm -rf in

# Add the compilers to the PATH
# This should give us 'ni', 'inform6' and 'cBlorb'
ENV PATH="${PATH}:/usr/local/share/inform7/Compilers"

# Crete the expected mount-point for the user's story.
# There's nothing here - the user mounts a volume into it.
WORKDIR /story.inform

# Install our convenience compiler script
# (the container command that does all the work)
WORKDIR /root
COPY docker-entrypoint.sh ./
RUN chmod a+x *.sh

# Set the container entrypoint
CMD ["./docker-entrypoint.sh"]
