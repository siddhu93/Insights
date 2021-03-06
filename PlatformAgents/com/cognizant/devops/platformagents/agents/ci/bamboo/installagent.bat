goto comment
Copyright 2017 Cognizant Technology Solutions
  
Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this file except in compliance with the License.  You may obtain a copy
of the License at
  
http://www.apache.org/licenses/LICENSE-2.0
  
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
License for the specific language governing permissions and limitations under
the License.
:comment
REM pushd %INSIGHTS_AGENT_HOME%\PlatformAgents\bamboo
IF /I "%1%" == "UNINSTALL" (
	net stop BambooAgent
	sc delete BambooAgent
) ELSE (
	net stop BambooAgent
	sc delete BambooAgent
    nssm install BambooAgent %INSIGHTS_AGENT_HOME%\PlatformAgents\bamboo\BambooAgent.bat
    net start BambooAgent
)