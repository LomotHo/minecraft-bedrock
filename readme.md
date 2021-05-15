README
=======================

__Origin:__ [lomot/minecraft-bedrock](https://registry.hub.docker.com/r/lomot/minecraft-bedrock/)


# Previous version
MCPE v1.16.210.x
```lomot/minecraft-bedrock:1.16.210.05```

# Default version
MCPE v1.16.220.x
```wilder/minecraft-bedrock:1.16.220.01```

## Release Notes
 * Created our own _minecraft-bedrock_ docker project based on _lomot/minecraft-bedrock_; forked the source on (github.com)
 * Changed mirror URLs ```sources.list``` to point to sites in the US
 * Added additional dependencies to help with learning the server and development.
 * Added different entrypoint configurations so that the server can be started with ```screen```
 * Made the Minecraft server admin console accessible by adding support to run it in the forground; made possible by ```screen```
 * Added custom entrypoint scripts that remove the dependency on ```start*.sh``` scripts while providing customized server environments (e.g. base config, development, etc.)

 

# How-tos...

__NOTE:__ ```PROJECT_ROOT``` and ```SERVER_HOME``` refer to the same location in these instructions.

## Server Configuration
Do this step after the image builds, but before starting the server.

 1. If you have a custom Bedrock server configuration, then proceed to _step 2_. Otherwise, you can safely ignore the remaining step and the default server configuration that ships with the server is automatically loaded.
 2. Select a Bedrock server config from ```profile/mcpe/configs```. The configs are group into different directories.
 3. Copy the contents of the select server config directory to the data folder ```[PROJECT_ROOT]/mcpe_data``` on the host. For example, assuming you are at the PROJECT_ROOT, this command will deploy the configuration called _default-survival-1_: ```cp profile/mcpe/configs/default-survival-1/* mcpe_data```.

## Running the server 

### with ```screen```
Provides access to the Bedrock server admin consonle using the ```screen``` app; a screen manager for terminal emulators.
__TODO: Add content__

### Development mode
__TODO: Add content__



# Work In-Progress / TODOs

* Better use Docker Buildkit for
	- Building secure images (High priority)
	- more performant builds (Low)
* Add script that periodically checks for new Bedrock releases and self-updates (High priority)
* Make docker image public (Low priority)
* Update ```docker-compose.yml```. (Low priority)
* Add python script for managing, controlling, and accessing the container (Medium priority)
* Docker questions
	- Does host networking mode work differently on Windows, Linux, and Mac?
* Remove from repo b/c no longer used or will not use
	- ```profile/container/advanced```
	- ```profile/container/aliases.sh```
	- ```profile/container/.bash_profile```
	- ```profile/mcpe/scripts/start*.sh``` __Docker CMD is no longer calling this file to start the server__
	- ```profile/container/sources.list``` __Is this still used? I don't think so. It was pointing at non-US Debian mirrors__
	- ```base.Dockerfile``` __Is this still used? I don't think so__
* Server configuration
	- Ideas:
		+ Do we upload ourcustom server configs from ```profile/mcpe/configs``` during image build time or post build?
		+ Should we merge the new default configs distributed with the server release with the custom configs?
		+ Should we preserved the original default configs distributed with the release?
* What is best solution for networking and port forwarding and does the host OS affect that? See comments in ```scripts/start.sh```
* Should Bedrock version be a build arg that is set in a docker enviroment config ```.env```? Or should the releases be grouped by version and the version number be updated in the files?
	- ```build.sh```
	- ```build-dev.sh```
	- ```README.md```
	- ```Dockerfile```
	- ```dev.Dockerfile```
	- ```VERSION```
	- ```start.sh```
	- ```start-entrypoint-override.sh```
	- ```start-entrypoint-override-nodaemon.sh```
	- ```dev/tmux``` and subdirectories
 * Clean up the content of the files in the directories:
 	- ```doc```
 		+ Update URL to point to our servers
 * Should we autogenerate release documentation?
 * Eventually cleanup Dockerfiles and refactor
 	- Remove unused and/or commented out commands
 	- ```Dockerfile``` 
 		+ should define a production environment and only have exactly what is needed to run (e.g. not extra entrypoint scripts, etc.)
 	- ```dev.Dockerfile``` 
 		+ should contain all the extra configurations, app, etc. needed for research and development
 * Use the ```dev/tmux``` variation as the base image.

# Default volume location
```
/var/lib/docker/volumes/mcpe-data/_data
```

# Info

## links 
 * [Minecraft Bedrock Download page](https://www.minecraft.net/en-us/download/server/bedrock)
 	- Downloading viw web UI requires EULA acknowledgement via checkbox. The server can be downloaded directly via download URLs below. Therefore, by-passing the EULA agreement. In the future, an automatic release download may need to be able to agree to the EULA before the URL is allowed and/or a Captcha may be used.
 * [Download Minecraft Bedrock version 1.16.220.01 for linux](https://minecraft.azureedge.net/bin-linux/bedrock-server-1.16.221.01.zip)
 * [Download Minecraft Bedrock version 1.16.220.01 for Windows](https://minecraft.azureedge.net/bin-win/bedrock-server-1.16.221.01.zip)


## tmux scratch

```bash
tmux new  -s mcpe "/mcpe/script/docker-entrypoint-noscreen.sh /mcpe/server/bedrock_server"
```

## WTFs

 * Dockerfiles
 	- Environment variables used to define ```ENTRYPOINT``` and ```CMD``` are not resolved. I used the expansion variable format ```${VARIABLE_NAME}``` to specify the variables and was using Docker Desktop + MacBook Pro 2020 (Intel)
