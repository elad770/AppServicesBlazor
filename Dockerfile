# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# העתק את קבצי הפרויקט ו restore תלותיות
COPY *.csproj ./
RUN dotnet restore

# העתק את שאר הקבצים ובנה את האפליקציה
COPY . ./
RUN dotnet publish -c Release -o out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out ./

# חשוף את הפורט ש-Render ישתמש בו
EXPOSE 80


ENTRYPOINT ["dotnet", "AppServices.dll"]
