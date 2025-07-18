FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["CornerShop/CornerShop.csproj", "CornerShop/"]
RUN dotnet restore "CornerShop/CornerShop.csproj"
COPY . .
WORKDIR "/src/CornerShop"
RUN dotnet build "CornerShop.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "CornerShop.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CornerShop.dll"] 