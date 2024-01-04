Docker scripts for Don't Starve Together Linux dedicated server

## Create Server Cluster

Visit https://accounts.klei.com/account/game/servers?game=DontStarveTogether

Type in cluster name, choose download settings, extract the zip file to `./MyDediServer`

You can adjust server settings specified in `.ini` files and DST world settings in `.lua` ones. Especially make sure the ports specified in `Caves/server.ini` and `Master/server.ini` correctly exposed below.

## Build and Run

Change the permission for mounted config and save files.

> There should be a better way to do this but I don't know how. `steam` user is preset in steamcmd, which may have different uid to host user, and to simplify the running process I move the download part to buildtime, runtime uid is also unknown here

~~~~shell
chmod -R 777 ./MyDediServer
~~~~

Change the arguments according to your settings. Base location is by default set to `/home/steam` in steamcmd.

~~~~shell
docker build . -t dst-dedicated:latest
docker run \
    -p 10999:10999/udp \
    -p 11000:11000/udp \
    -v $(pwd)/MyDediServer:/home/steam/.klei/DoNotStarveTogether/MyDediServer \
    --name dst-dedicated \
    -it dst-dedicated
~~~~
