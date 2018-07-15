<<<<<<< HEAD
=======

>>>>>>> 8b27d3269ca50e8186b56b5e10f491659dbfa460
FROM ubuntu:16.04
RUN apt-get -qq update && apt-get install --no-install-recommends -y python-pip python-dev npm git
RUN npm install -g bower
RUN apt-get install -y curl
RUN apt-get install --no-install-recommends - nodejs-legacy
RUN apt-get install -y nano vim
RUN git clone https://github.com/densitydesign/raw.git
RUN cd raw && bower install --allow-root && cp js/analytics.sample.js js/analytics.js
EXPOSE 4000
CMD cd /raw && python -m SimpleHTTPServer 4000
