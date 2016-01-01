#!/bin/bash --

######################################################
# postDeploy.sh : Script to run environment / app specific actions
#    after config / deployment. This script is meant to be zero-config, 
#	 i.e. not dependent on any other files and self-discovering.
######################################################

######################################################
# Variables
######################################################
configPath=
binPath=
hostName=`hostname`
appname=
envname=
servernumber=
let isVerizon=0
let debug=0

######################################################
# Functions
######################################################
function isVerizonServer
{
	if [[ "$hostName" =~ vzw-rds ]] 
	then
		let isVerizon=1	
	else
		let isVerizon=0
	fi
}

function getBasePaths
{
	binPath=$( builtin cd -- "${0%/*}" ; builtin pwd -P )
	configPath="${binPath%/*}/conf"
}

function parseHostName
{
	if [[ "$hostName" =~ rds-([a-z]+)-([a-z]+)-([0-9]+) ]] 
	then
		appname=${BASH_REMATCH[1]}
		envname=${BASH_REMATCH[2]}
		servernumber=${BASH_REMATCH[3]}	
	else
		echo "ERROR: Non-standard hostname : $hostName"
		return 1 
	fi
	return 0
}

function stripeDb
{
	filepath="$configPath/cms.c3po.data-source-initializers.inc.xml"
	
	if (( $servernumber % 2 == 0 ))
	then
		# Stripe to CMSARP02
		cp ${filepath}_CMSARP02 $filepath			 
	else
		# Stripe to CMSARP01
		cp ${filepath}_CMSARP01 $filepath			 
	fi
}

function fixJmxFiles
{
	filepath="$configPath/jmxremote.*"
	chmod 400 $filepath
}

######################################################
# MAIN
######################################################

# Get required folder paths
getBasePaths
if (( $debug == 1 ))
then
	echo "binPath: $binPath"
	echo "configPath: $configPath"
fi

# Parse hostname
parseHostName

if (( $? == 1 ))
then
	echo "Failed to parse hostname. Aborting script!"
	exit 1
fi

if (( $debug == 1 ))
then
	echo "application: $appname"
	echo "environment: $envname"
	echo "server number: $servernumber"
fi

# chmod JMX password file
if (( $debug == 1 ))
then
	echo "Fixing Jmx remote access files"
fi
fixJmxFiles
