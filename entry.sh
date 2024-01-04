#!/bin/bash
# reference
# https://github.com/joedwards32/CS2/blob/main/bullseye/etc/entry.sh
# https://steamcommunity.com/sharedfiles/filedetails/?id=590565473

# update
bash "${STEAMCMDDIR}/steamcmd.sh" \
    +force_install_dir "${STEAMAPPDIR}" \
    +login anonymous \
    +app_update "${STEAMAPPID}" \
    +quit

# launch master and cave server
cd ${STEAMAPP}-dedicated/bin
./dontstarve_dedicated_server_nullrenderer -console -cluster MyDediServer -shard Master &
./dontstarve_dedicated_server_nullrenderer -console -cluster MyDediServer -shard Caves &

sleep infinity