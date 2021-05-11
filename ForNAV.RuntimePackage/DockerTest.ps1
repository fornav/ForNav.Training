$artifactUrl = Get-BCArtifactUrl -country base #Cloud sandbox with demo data
# $artifactUrl = Get-BCArtifactUrl -version 18 -type OnPrem -country w1 -select Latest
$containerName = 'bc18-runtime'
$credential = New-Object pscredential 'admin', (ConvertTo-SecureString -String 'admin' -AsPlainText -Force)
$licenseFile = '.\BC18 On Prem ForNAV.flf'

New-BcContainer `
    -accept_eula `
    -containerName $containerName `
    -artifactUrl $artifactUrl `
    -Credential $credential `
    -auth UserPassword `
    -licenseFile $licenseFile `
    -updateHosts

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
