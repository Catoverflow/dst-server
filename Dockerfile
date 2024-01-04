# reference
# https://github.com/joedwards32/CS2/blob/main/bullseye/Dockerfile
# https://steamcommunity.com/sharedfiles/filedetails/?id=590565473
# with the help of GPT-4

FROM cm2network/steamcmd:root

ENV STEAMAPPID 343050
ENV STEAMAPP dst
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

RUN set -x && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y libcurl4-gnutls-dev:i386

COPY entry.sh "${HOMEDIR}/entry.sh"
RUN chmod +x "${HOMEDIR}/entry.sh"

RUN mkdir -p ${STEAMAPPDIR}
RUN chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}"

USER ${USER}
WORKDIR ${HOMEDIR}

# download the game itself
RUN "${STEAMCMDDIR}/steamcmd.sh" \
    +force_install_dir "${STEAMAPPDIR}" \
    +login anonymous \
    +app_update "${STEAMAPPID}" \
    +quit

# create folder for server settings specified in runtime
RUN mkdir -p "${HOMEDIR}/.klei/DoNotStarveTogether"

# see readme
# RUN echo -e "your base location is ${HOMEDIR}\"

# CMD ["bash", "entry.sh"]
ENTRYPOINT [ "sleep", "infinity" ]