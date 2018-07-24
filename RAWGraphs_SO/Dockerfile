#Dockerfile for running RAWGraphs.

#Use Ubuntu 16.04 as base image.
FROM ubuntu:16.04

#Maintainer tag.
LABEL maintainer "pr1malbyt3s and bryant-treacle"

#Install dependencies needed.
RUN apt-get -qq update && apt-get install --no-install-recommends -y npm git
RUN npm install -g bower
RUN apt-get install -y curl
RUN apt-get install --no-install-recommends - nodejs-legacy
RUN apt-get install -y nano vim

#Set working directory and path.
WORKDIR /usr/share/rawgraphs
ENV PATH=/usr/share/rawgraphs:$PATH

#Download RAWGraphs.
RUN git clone https://github.com/densitydesign/raw.git
RUN cd raw && bower install --allow-root && cp js/analytics.sample.js js/analytics.js

#Create unprivileged user to run process.
RUN groupadd --gid 937 rawgraphs && \
    useradd --uid 937 --gid 937 \
      --home-dir /usr/share/rawgraphs --no-create-home \
      rawgraphs

#Change permissions on all files for rawgraphs user.
RUN chown --recursive rawgraphs:rawgraphs /usr/share/rawgraphs/*

#Enjoy some humor in our struggles.
RUN echo "#!/bin/bash" > /usr/share/rawgraphs/stupid.sh
RUN echo 'while true; do echo "docker should make this easier... also data analytics is a waste of time" > /usr/share/rawgraphs/stupid.txt; sleep 10; done' >> /usr/share/rawgraphs/stupid.sh
RUN chmod 755 /usr/share/rawgraphs/stupid.sh

#Switch user and start process.
USER rawgraphs
CMD ./usr/share/rawgraphs/stupid.sh
