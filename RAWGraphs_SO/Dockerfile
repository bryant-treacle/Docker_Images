FROM ubuntu:16.04
RUN apt-get -qq update && apt-get install --no-install-recommends -y npm git
RUN npm install -g bower
RUN apt-get install -y curl
RUN apt-get install --no-install-recommends - nodejs-legacy
RUN apt-get install -y nano vim
RUN git clone https://github.com/densitydesign/raw.git
RUN cd raw && bower install --allow-root && cp js/analytics.sample.js js/analytics.js
RUN echo "#!/bin/bash" > stupid.sh
RUN echo 'while true; do echo "docker should make this easier..." > stupid.txt; sleep 10; done' >> stupid.sh
RUN chmod 755 stupid.sh
CMD ./stupid.sh
