C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild ../EntityLoaders.sln /p:Configuration=Release
..\.nuget\nuget pack ../EntityLoaders/EntityLoaders.csproj -Properties Configuration=Release
..\.nuget\nuget push *.nupkg
del *.nupkg