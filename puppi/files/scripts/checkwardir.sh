#!/bin/bash
# checkwardir.sh - Made for Puppi
# This script checks if a WAR file is successfully expanded in the omonimous directory

configfile="/etc/puppi/puppi.conf"

# Load general configurations
if [ ! -f $configfile ] ; then
    echo "Config file: $configfile not found"
    exit 2
else
    . $configfile
    . $scriptsdir/functions
fi

# Load project runtime configuration
projectconfigfile="$workdir/$project/config"
if [ ! -f $projectconfigfile ] ; then
    echo "Project runtime config file: $projectconfigfile not found"
    exit 2
else
    . $projectconfigfile
fi
# Show help
showhelp () {
    echo "This script is used to check if a webapp directory is successfully created or removed"
    echo " after the (un)deploy of a war file"
    echo "It implies that a directory with the name of the war file is created in the same path"
    echo "It has 2 required arguments:"
    echo "First argument (\$1 - required) is the absolute path of the deployed war"
    echo "Second argument (\$2 - required) defines what to check (absent|present)"
    echo 
    echo "Examples:"
    echo "checkwardir.sh /store/tomcat/myapp/webapps/myapp.war present"
    echo "checkwardir.sh /store/tomcat/myoldapp/webapps/myoldapp.war absent"
}

# Manage script variables
if [ $1 ] ; then
    warfile=$1
    wardir=${warfile%\.*}
else
    showhelp
    exit 2 
fi

if [ $2 ] ; then
    status=$2
else
    showhelp
    exit 2 
fi

checkdir () {
    while true
       do
        if [ $status == absent ] ; then
            [ ! -d $wardir ] && break
        else
            [ -d $wardir ] && break
        fi
        sleep 1
    done
}

checkdir
