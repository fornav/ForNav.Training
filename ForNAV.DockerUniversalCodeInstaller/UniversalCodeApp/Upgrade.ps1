# Sample install script
# This is a simplified example, which does not do other operations that may be needed.
# The administration module must be loaded for this script to run.
$dllVersion = "7.0.0.2398"
$appVersion = "7.0.0.8"
$instance = "BC"

function InstallApplication($path, $name, $version) {
    Write-Host "Install $name"
    Publish-NAVApp -ServerInstance $instance -SkipVerification -Path $path
    Sync-NAVApp -ServerInstance $instance -Name $name -Version $version -Mode Add -Force -ErrorAction Stop
    Install-NAVApp -ServerInstance $instance -Name $name -Version $version
}

function UpgradeApplication($path, $name, $version) {
    Write-Host "Upgrade $name"
    Publish-NAVApp -ServerInstance $instance -SkipVerification -Path $path
    Sync-NAVApp -ServerInstance $instance -Name $name -Version $version -Mode ForceSync -Force -ErrorAction Stop
    Start-NAVAppDataUpgrade -ServerInstance $instance -Name $name -Version $version
}

Start-Process -FilePath .\ReportsForNAV.exe -ArgumentList /COMPONENTS=”deployment\reportservice", /VERYSILENT, /NORESTART, /SUPPRESSMESSAGEBOXES, /LOG=".\fnlog.txt"

InstallApplication ".\ForNAV Language Module $appVersion.app" 'ForNAV Language Module' $appversion
UpgradeApplication ".\ForNAV Core $appVersion.app" 'ForNAV Core' $appversion
UpgradeApplication ".\ForNAV Customizable Report Pack $appVersion.app" 'Customizable Report Pack' $appVersion
# InstallApplication ".\ForNAV Service $dllVersion.app" 'ForNAV Service' $dllVersion
InstallApplication ".\ForNAV Service (experimental version using HTTP service) $dllVersion.app" 'ForNAV Service' $dllVersion
