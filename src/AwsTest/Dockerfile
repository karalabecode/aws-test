#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["AwsTest/AwsTest.csproj", "AwsTest/"]
RUN dotnet restore "AwsTest/AwsTest.csproj"
COPY . .
WORKDIR "/src/AwsTest"
RUN dotnet build "AwsTest.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "AwsTest.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "AwsTest.dll"]
