## RAWGraphs_SO Docker Image
This Docker image was built to be run on Security Onion behind the already existing web proxy. The install script utilizes whiptail to download the Docker image and make the necessary changes to the Apache SecurityOnion.conf file.

# Directions:
1) Download rawgraphs_so_package.tar.gz either manually or with the command: ```wget https://github.com/pr1malbyt3s/Docker_Images/edit/master/RAWGraphs_SO/rawgraphs_so_package.tar.gz --output rawgraphs_so_package.tar.gz```

2) Decompress downloaded package with the command: ```tar -zxvf rawgraphs_so_package.tar.gz ```

3) Change into the rawgraphs_so_package folder with the command: ```cd rawgraphs_so_package/```

4) Change permissions of the install script using the command: ```sudo chmod 755 rawgraphs_so_install.sh```

5) Run the install script using the command: ```sudo ./rawgraphs_so_install.sh```

6) You will be prompted with an installation prompt screen: *insert image* . Select ```zipped_image``` to use the image downloaded in this package or select ```Latest_image``` to pull the latest image from Docker Hub. The installation will then complete based on your selection.

7) You can then begin using RAWGraphs by visiting https://localhost/rawgraphs.

Enjoy!





