# ----------------------------------
# Kerbal Space Program - LunaMultiplayer Dockerfile
# Environment: dotnet
# ----------------------------------
FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine

ARG LMP_VERSION=0.28.0
ARG LMP_FILENAME=LunaMultiplayer-Server-Debug.zip

ARG LMP_URL=https://github.com/LunaMultiplayer/LunaMultiplayer/releases/download/$LMP_VERSION/$LMP_FILENAME

RUN apk add --no-cache --update icu-libs libstdc++ libgcc wget \
    && adduser --disabled-password --home /home/container container

RUN cd /home/container && \
    wget $LMP_URL && \
    unzip $LMP_FILENAME && \
    rm -rf $LMP_FILENAME LMP\ Readme.txt

# EXPOSE 8800/udp 8900/tcp
# VOLUME "/LMPServer/Config" "/LMPServer/Plugins" "/LMPServer/Universe" "/LMPServer/logs"
# STOPSIGNAL sigint
# WORKDIR /LMPServer

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
# CMD ["dotnet", "Server.dll"]