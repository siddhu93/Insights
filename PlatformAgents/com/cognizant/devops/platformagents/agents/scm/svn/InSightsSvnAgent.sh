#-------------------------------------------------------------------------------
# Copyright 2017 Cognizant Technology Solutions
#   
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License.  You may obtain a copy
# of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations under
# the License.
#-------------------------------------------------------------------------------
#! /bin/sh
# /etc/init.d/InSightsSvnAgent

### BEGIN INIT INFO
# Provides: Runs a Python script on startup
# Required-Start: BootPython start
# Required-Stop: BootPython stop
# Default-Start: 2 3 4 5
# Default-stop: 0 1 6
# Short-Description: Simple script to run python program at boot
# Description: Runs a python program at boot
### END INIT INFO
#export INSIGHTS_AGENT_HOME=/home/ec2-user/insightsagents
source /etc/profile

case "$1" in
  start)
    if [[ $(ps aux | grep '[s]cm.svn.svnAgent' | awk '{print $2}') ]]; then
     echo "InSightsSvnAgent already running"
    else
     echo "Starting InSightsSvnAgent"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/svn
     python -c "from com.cognizant.devops.platformagents.agents.scm.svn.svnAgent import svnAgent; svnAgent()" &
    fi
    if [[ $(ps aux | grep '[s]cm.svn.svnAgent' | awk '{print $2}') ]]; then
     echo "InSightsSvnAgent Started Sucessfully"
    else
     echo "InSightsSvnAgent Failed to Start"
    fi
    ;;
  stop)
    echo "Stopping InSightsSvnAgent"
    if [[ $(ps aux | grep '[s]cm.svn.svnAgent' | awk '{print $2}') ]]; then
     sudo kill -9 $(ps aux | grep '[s]cm.svn.svnAgent' | awk '{print $2}')
    else
     echo "InSIghtsSvnAgent already in stopped state"
    fi
    if [[ $(ps aux | grep '[s]cm.svn.svnAgent' | awk '{print $2}') ]]; then
     echo "InSightsSvnAgent Failed to Stop"
    else
     echo "InSightsSvnAgent Stopped"
    fi
    ;;
  restart)
    echo "Restarting InSightsSvnAgent"
    if [[ $(ps aux | grep '[s]cm.svn.svnAgent' | awk '{print $2}') ]]; then
     echo "InSightsSvnAgent stopping"
     sudo kill -9 $(ps aux | grep '[s]cm.svn.svnAgent' | awk '{print $2}')
     echo "InSightsSvnAgent stopped"
     echo "InSightsSvnAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/svn
     python -c "from com.cognizant.devops.platformagents.agents.scm.svn.svnAgent import svnAgent; svnAgent()" &
     echo "InSightsSvnAgent started"
    else
     echo "InSightsSvnAgent already in stopped state"
     echo "InSightsSvnAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/svn
     python -c "from com.cognizant.devops.platformagents.agents.scm.svn.svnAgent import svnAgent; svnAgent()" &
     echo "InSightsSvnAgent started"
    fi
    ;;
  status)
    echo "Checking the Status of InSightsSvnAgent"
    if [[ $(ps aux | grep '[s]cm.svn.svnAgent' | awk '{print $2}') ]]; then
     echo "InSightsSvnAgent is running"
    else
     echo "InSightsSvnAgent is stopped"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/InSightsSvnAgent {start|stop|restart|status}"
    exit 1
    ;;
esac
exit 0
