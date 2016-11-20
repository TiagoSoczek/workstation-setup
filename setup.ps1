# https://msdn.microsoft.com/en-us/virtualization/windowscontainers/quick_start/quick_start_windows_10
Enable-WindowsOptionalFeature -Online -FeatureName Containers -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All

Restart-Computer -Force

Set-ExecutionPolicy unrestricted
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

Get-PackageProvider -name chocolatey -Force
Set-PackageSource -Name chocolatey -Trusted 

install-package GoogleChrome
install-package Firefox
install-package 7zip
install-package visualstudiocode
install-package tortoisegit
install-package spotify
install-package jdk8
install-package skype
install-package fiddler
install-package ilspy
install-package nodejs.install

# Instalar Office
# Instalar Visual Studio
# Instalar .NET Core
# Instalar Resharper

(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
Install-Module posh-git

# Instalar IIS
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45 -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HealthAndDiagnostics -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpLogging -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibraries -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestMonitor -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpTracing -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Security -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-URLAuthorization -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-IPSecurity -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Performance -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionDynamic -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-IIS6ManagementCompatibility -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Metabase -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HostableWebCore -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CertProvider -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DigestAuthentication -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ClientCertificateMappingAuthentication -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-IISCertificateMappingAuthentication -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ODBCLogging -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DirectoryBrowsing -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebDAV -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationInit -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45 -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASP -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CGI -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ServerSideIncludes -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CustomLogging -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-BasicAuthentication -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementService -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WMICompatibility -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-LegacyScripts -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-LegacySnapIn -All

Enable-WindowsOptionalFeature -Online -FeatureName NetFx4Extended-ASPNET45 -All

# Configurar Binding SSL
Push-Location IIS:\SslBindings
 
New-WebBinding -Name "Default Web Site" -IP "*" -Port 443 -Protocol https

$sslCert = New-SelfSignedCertificate -DnsName localhost -CertStoreLocation Cert:\LocalMachine\My

Get-Item Cert:\LocalMachine\MY\$strThumb | New-Item 0.0.0.0!443
Pop-Location

Restart-Service W3SVC
