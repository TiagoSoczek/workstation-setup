Enable-WindowsOptionalFeature -Online -FeatureName Containers -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All

Restart-Computer -Force

# Install choco
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n=allowGlobalConfirmation

choco install googlechrome
choco install 7zip.install
choco install git.install
choco install sysinternals
choco install visualstudiocode
choco install cmder
choco install tortoisegit
choco install jdk8
choco install skype
choco install fiddler
choco install ilspy
choco install nodejs.install

# Installl Office
# Installl Visual Studio
# Installl .NET Core
# Installl Resharper

(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
Install-Module posh-git

# Install IIS - All features - Only for dev machine
Enable-WindowsOptionalFeature -Online -FeatureName IIS-* -All

Import-Module WebAdministration

# Remove defaults
Remove-WebAppPool -Name *
Remove-Website -Name *

# Create Default AppPool and Default Site
New-WebAppPool -Name DefaultPool
New-Website -Name Default -Port 80 -PhysicalPath C:\inetpub\wwwroot\ -ApplicationPool DefaultPool

# Add HTTPS binding
New-WebBinding -Name Default -Protocol https

# Create self-signed certificate
$cert = New-SelfSignedCertificate -DnsName localhost, $env:COMPUTERNAME -CertStoreLocation Cert:\LocalMachine\My

# Trust it
$rootStore = New-Object System.Security.Cryptography.X509Certificates.X509Store -ArgumentList Root, LocalMachine
$rootStore.Open("MaxAllowed")
$rootStore.Add($cert)
$rootStore.Close()

# And add to binding
pushd IIS:\SslBindings
$cert | New-Item 0.0.0.0!443
popd
