
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o /app


FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

COPY --from=build /app .

COPY .env .

ENV ASPNETCORE_URLS=http://0.0.0.0:8080
EXPOSE 8080

COPY news.db .

ENTRYPOINT ["dotnet", "newsApi.dll"]