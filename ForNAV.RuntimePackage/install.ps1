# Sample install script
$dllVersion="6.0.0.2075"
$appVersion="6.0.0.0"
$BCVersion = "180"
$navmodule = "C:\Program Files\Microsoft Dynamics Business Central\" + $BCVersion + "\Service\NavAdminTool.ps1"
Import-Module $navmodule -WarningAction SilentlyContinue | Out-Null
Set-Location -Path $PSScriptRoot
$instance="BC180"

function InstallApplication($path, $name, $version)
{
    Publish-NAVApp -ServerInstance $instance -SkipVerification -Path $path
    Sync-NAVApp -ServerInstance $instance -Name $name -Version $version -Mode Add -Force -ErrorAction SilentlyContinue -ErrorVariable err
    Install-NAVApp -ServerInstance $instance -Name $name -Version $version
}
InstallApplication ".\ForNAV Language Module_$dllVersion.app" 'ForNAV Language Module' $dllVersion
InstallApplication ".\ForNAV Core_$dllVersion.app" 'ForNAV Core' $dllVersion
InstallApplication ".\ForNAV_Customizable Report Pack_$appVersion.app" 'Customizable Report Pack' $appVersion
InstallApplication ".\ForNAV Service_$dllVersion.app" 'ForNAV Service' $dllVersion

