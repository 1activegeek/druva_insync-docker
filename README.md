# Druva inSync Docker container
A simple [Druva inSync](https://www.druva.com) container for Docker testing  

*Please note, this container will not allow full fledged use or access to a Druva inSync instance. This will simply afford you a simple containerized client for testing purposes with your own Druva inSync instance.*

## Example Usage
```
docker create \
-e INSYNC_TOKEN="xxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxx" \
-e INSYNC_MAIL="user@domain.org" \
-e INSYNC_USERNAME="User Name" \
--name=insync \
1activegeek/druva_insync
```

## Environment Variables - with defaults listed
`-e INSYNC_ADDRESS="cloud.druva.com"` *(REQUIRED)* \
`-e INSYNC_PORT="443"` *(REQUIRED)* \
`-e INSYNC_STORAGE=""` \
`-e INSYNC_PROFILE=""` \
`-e INSYNC_USERNAME=""` \
`-e INSYNC_MAIL=""` *(REQUIRED)* \
`-e INSYNC_TOKEN=""` *(REQUIRED)* \
`-e INSYNC_DOWNLOAD="https://downloads.druva.com/downloads/inSync/Linux/5.9/druva-insync-client_5.9-51251_amd64.deb"` *(REQUIRED)* \
`-e USER="druva"` \
`-e HOME="/home/druva/"`

## Container Setup/Layout Info
There is no need to configure any specific ports to be opened. The way the app operates, it will be opening an outbound only connection to the cloud based servers. Once this persistent connection is made, backups will process as required without any further port openings.

Upon startup, the container will enter the required details into a config file which will be written. Once written, the container will then launch the inSync process in a virtual X session to allow the application to function as though it was installed on an ordinary Debian based desktop OS. 

Optionally data can be mounted to locations as desired. The container is setup to run as User: `druva`, and it's home directory is `/home/druva`. Depending on how the profile has been configured on the Druva console, will determine what data will be backed up. If changing the default configuration, you may see errors on the console of "misconfigured backup folder" due to the missing directory in the container. Permissions can also cause problems as often known in Docker containers. User `druva` will likely be running as `UID 1000` and `GID 1000`. If permissions are mapped/matched on the local host it can ease the potential issues. 
