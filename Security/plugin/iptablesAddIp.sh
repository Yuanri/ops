#!/bin/bash
#
# Jose' Vargas <https://github.com/josev814>
# To use this plugin, place it in a directory such as /var/local/bin, and make it executable
# Then in /etc/denyhosts.conf look for PLUGIN_PURGE, and set the path to the file.
# ex: PLUGIN_PURGE=/var/local/bin/iptablesRemoveIp.sh
#

#function to write to the log file determined by /etc/denyhosts.conf
function writeToLog () {
  #Get log file location
  logFileLocation=`cat /etc/denyhosts.conf | grep ^DAEMON_LOG\ = | awk '{ print $3 }'`
 
  # Get the current time for logging purposes
  time=`date +"%Y-%m-%d %T"`

  if [[ $1 == 1 ]]
  then
    #get the iprule args to write to log and delete from iprules from the passed argument
    ipRule=$2
    
    #write what we're doing to the log
    echo "$time,32 - iptablesAddIp       : INFO  Add  $ipRule into the iptables INPUT rules" >> $logFileLocation
  else
    echo "$time,34 - iptablesAddIp       : INFO  No rules to add into  iptables INPUT rules" >> $logFileLocation
  fi
}

# Get the IP from the cli
ip=$1

# Get settings from denyhosts.conf
ipTablesLocation=`cat /etc/denyhosts.conf | grep IPTABLES\ = | awk '{ print $3 }'`


#if the rule count is 1 then we don't have an array
if [[ "1$ip" != "1" ]]
then
  ipRules="-A INPUT -s $ip -j DROP"
  writeToLog 1 "$ipRules"
  $ipTablesLocation $ipRules
fi
