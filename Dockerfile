FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine

#VOLUME "/LMPServer/Config" "/LMPServer/Plugins" "/LMPServer/Universe" "/LMPServer/logs"

#STOPSIGNAL sigint

USER container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]

#CMD ["dotnet", "Server.dll"]