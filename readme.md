Docker scripts for Don't Starve Together Linux dedicated server

## Create Server Cluster

Visit https://accounts.klei.com/account/game/servers?game=DontStarveTogether

Type in cluster name, choose download settings, extract the zip file to `./MyDediServer`

You can adjust server settings specified in `.ini` files and DST world settings in `.lua` ones. Especially make sure the ports specified in `Caves/server.ini` and `Master/server.ini` are correctly exposed below.

## Build and Run

Change the permission for mounted config and save files.

> There should be a better way to do this but I don't know how. `steam` user is preset in steamcmd, which may have different uid to host user

~~~~shell
chmod -R 777 ./MyDediServer
~~~~

> Change the ports according to your settings. By default 10999 for Master and 11000 for Cave.

~~~~shell
docker run \
    -p 10999:10999/udp \
    -p 11000:11000/udp \
    -v $(pwd)/MyDediServer:/home/steam/.klei/DoNotStarveTogether/MyDediServer \
    --name dst-dedicated 
    -it catoverflow/dst-server
~~~~

An example docker compose yaml file is also included.

### Modding

Follow the instructions in container at `/home/steam/dst-dedicated/mods/dedicated_server_mods_setup.lua`

For mod settings, you can configure them in DST GUI and ship the settings at `~/.klel/DoNotStarveTogether/MyDediServer/[Master|Cave]/modoverrides.lua`

## DEPRECATED - Tmux is not recommended as this method forces you to -it in to the container and also prevent docker compose yamls from being used. Only left here for reference.
## Manage DST CLI 

[Tmux](https://www.redhat.com/sysadmin/introduction-tmux-linux) is used in multi-process management. A `DST-dedicated` session is created with window `Master` and `Cave` responsible for Master (main world) and Cave server.

~~~~shell
docker attach dst-dedicated
# then use ^C-b + [0|1] to switch between Master and Cave tmux windows, ^C-p + q to detach from container
~~~~

## Docker Build instructions
Image can be built using regular docker build commands, however, If you are on an ARM machine (Apple Silicon or other) you will need to use buildx. The following command is an example of how to build the image using buildx on an ARM device for amd 64. And ofc, after building, you'll need to tag your image for push. Enjoy.

~~~~shell
docker buildx build . --load --platform linux/amd64
~~~~

## Known Issues

- Mapping different ports for cave server will make it unusable. Once you enter the cave you will be locked out, as the master server keeps redirecting you to inaccessible cave server port outside the container.
- If offline mode or LAN only option is on, only ports within range [10998, 11018] can be used. This is DST feature :）
