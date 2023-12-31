##########################################################################
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 3000
#ENV ASPNETCORE_URLS=http://*:3000
##########################################################################
# LABEL maintainer="%SERVICE_NAME%" \
#       name="%CUSTOM_PLUGIN_SERVICE_NAME%" \
#       description="%CUSTOM_PLUGIN_SERVICE_NAME%" \
#       eu.mia-platform.url="https://todo.com" \
#       eu.mia-platform.version="0.1.0" \
#       eu.mia-platform.language="c#" \
#       eu.mia-platform.framework=".net core 6.0"
##########################################################################
FROM base AS final
WORKDIR /app
ARG SERVICE_NAME
ARG SOURCE_PATH

ARG VERSION
ARG COMMIT_SHA=<not-specified>

ENV SERVICE $SERVICE

COPY "${SOURCE_PATH}/${SERVICE_NAME}/${VERSION}" ./

RUN echo "%SERVICE_NAME%: $COMMIT_SHA" >> ./commit.sha

CMD ["dotnet", "${SERVICE_NAME}.dll"]