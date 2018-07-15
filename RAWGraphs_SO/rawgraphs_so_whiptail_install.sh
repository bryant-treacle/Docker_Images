#!/bin/bash
#Purpose: This script will install the data visualization program rawgraphs as a docker container on ubuntu 16.
#Creation Date: 14 July
#Last Modified: 14 July


main_prompt()
{
rawgraph_install_option=$(whiptail --title "Docker Install Options" --radiolist \
"A zipped copy of the docker container has been included for offline install.\n\n Please choose from the below options:" 15 100 4 \
"Zipped_image" "Use the provided docker image" ON \
"Latest_image" "Pull the latest image from docker hub" OFF \
"Exit" "Exit the installation" OFF 3>& 1>&2 2>&3)
}

########################
# Docker image install #
########################

rawgraph_install_prompt()
{
# Unpacking docker container
    echo "Unpacking rawgraphs docker image"
    gzip -d rawgraphs_so.tar.gz
# Loading rawgrapsh docker container
    docker load --input rawgraphs_so.tar
}

rawgraph_docker_pull()
{
    docker pull pr1malbyt3s/rawgraphs_so
}

rawgraph_docker_start()
{
# Starting Rawgraphs docker container and mounting volume to give apache2 access to the index.html file
    docker run --name=rawgraphs --volume /var/www/so/rawgraphs/:/rawgraphs/: -d 03a4c76d6e00
    docker exec -it rawgraphs bash -c "cd /raw && cp -R * /rawgraphs/"
}

###################################################################################
# Adding necessary code to the securityonion.conf in /etc/apache2/sites-available/#
###################################################################################

rawgraph_apache2_conf()
{
# Finding the line number of <location /capme>
    nums=$(cat /etc/apache2/sites-available/securityonion.conf | grep -n capme | cut -d':' -f1)
# Creating a variable containing the necessary rawgraphs apache configs
read -r -d '' RAWGRAPHS <<- EOM

                <Location /rawgraphs>
                        AuthType form
                        AuthName "Security Onion"
                        AuthFormProvider external
                        AuthExternal so-apache-auth-sguil
                        Session On
                        SessionCookieName session path=/;httponly;secure;
                        SessionCryptoPassphraseFile /etc/apache2/session
                        ErrorDocument 401 /login-inline.html
                        AuthFormFakeBasicAuth On
                        Require valid-user
                </Location>
EOM
# Creating a new securityonion.conf file with the rawgraphs configs and saving as a variable
    RAGRAPHS_CONFIG=$(awk -v "n=$nums" -v "s=$RAWGRAPHS" '(NR==n) { print s } 1' /etc/apache2/sites-available/securityonion.conf)
# Creating a backup of the securityonion.conf file
   cp /etc/apache2/sites-available/securityonion.conf /etc/apache2/sites-available/securityonion.conf.bak
# Replacing old securityonion.conf with new config and restarting Apache2 service
    echo "$RAGRAPHS_CONFIG=" >  /etc/apache2/sites-available/securityonion.conf
    systemctl restart apache2
echo "You can access Rawgraphs using the following url https://localhost/rawgraphs"
}

###############
# Main Script #
###############

main_prompt
    if [ $rawgraph_install_option = "Zipped_image" ] ; then
        rawgraph_install_prompt
        rawgraph_docker_start
        rawgraph_apache2_conf
    elif [ $rawgraph_install_option = "Latest_image" ] ; then
        rawgraph_docker_pull
        rawgraph_docker_start
        rawgraph_apache2_conf
    else
        exit
    fi
