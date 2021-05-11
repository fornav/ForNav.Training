$BCVersion = "18"
$BCCountry = "de"
$hostname = "BC-DEV-CWS"
[bool] $preview = $false
$sasToken = "*"

$passwdsec = Read-Host 'Input the user`s password' -AsSecureString

$credential = New-Object pscredential $env:USERNAME, $passwdsec

if ($preview -eq $true) {
    #$artifacturl = Get-BCArtifactUrl -storageAccount bcpublicpreview -type sandbox -version $BCVersion -country $BCCountry -select latest
    $artifacturl = Get-BCArtifactUrl -storageAccount bcinsider -sasToken $sasToken -type sandbox -version latest -country $BCCountry -select latest
} else { 
    $artifacturl = Get-BCArtifactUrl -storageAccount bcartifacts -type sandbox -version $BCVersion -country $BCCountry -select Latest
}

Write-Host "Artifact-URL: $artifacturl"
Write-Host "Hostname: $hostname"

New-BcContainer `
    -accept_eula `
    -containerName $hostname `
    -artifactUrl $artifacturl `
    -auth=Windows `
    -Credential $credential `
    -updateHosts `
    -assignPremiumPlan `
    -licenseFile 'X:\Sync\Red and Bundle\Licenties\BC18 On Prem ForNAV + Own Objects.flf'`
    -isolation process

Add-FontsToBCContainer -containerName $containerName -path c:\windows\fonts\*.ttf

Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV Language Module_6.0.0.2075.app' -containerName $hostname -skipVerification 
Sync-BcContainerApp -appName "ForNAV Language Module" -Force -containerName $hostname
Install-BcContainerApp -appName "ForNAV Language Module" -containerName $hostname

Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV Core_6.0.0.2075.app' -containerName $hostname -skipVerification 
Sync-BcContainerApp -appName "ForNAV Core" -Force -containerName $hostname
Install-BcContainerApp -appName "ForNAV Core" -containerName $hostname

Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV_Customizable Report Pack_6.0.0.0.app' -containerName $hostname -skipVerification 
Sync-BcContainerApp -appName "Customizable Report Pack" -Force -containerName $hostname
Install-BcContainerApp -appName "Customizable Report Pack" -containerName $hostname

Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV Service_6.0.0.2075.app' -containerName $hostname -skipVerification 
Sync-BcContainerApp -appName "ForNAV Service" -Force -containerName $hostname
Install-BcContainerApp -appName "ForNAV Service" -containerName $hostname
