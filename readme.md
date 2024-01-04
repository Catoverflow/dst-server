Docker scripts for Don't Starve Together Linux dedicated server

## Create Server Cluster

Visit https://accounts.klei.com/account/game/servers?game=DontStarveTogether

Type in cluster name, choose download settings, extract the zip file to `./MyDediServer`

You can adjust server settings specified in `.ini` files and DST world settings in `.lua` ones. Especially make sure the ports specified in `Caves/server.ini` and `Master/server.ini` correctly exposed below.

## Build and Run

Change the permission for mounted config and save files.

> There should be a better way to do this but I don't know how

~~~~shell
chmod -R 777 ./MyDediServer
~~~~

Change the arguments according to your settings. Base location is by default set to `/home/steam` in steamcmd.

~~~~shell
docker build . -t dst-dedicated:latest
docker run \
    -p 11000:11000/udp \
    -p 11001:11001/udp \
    -v MyDediServer:/home/steam/.klei/DoNotStarveTogether/MyDediServer \
    --name dst-dedicated \
    -it dst-dedicated &
~~~~