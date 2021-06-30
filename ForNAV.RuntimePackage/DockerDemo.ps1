Import-Module BcContainerHelper

$artifactUrl = Get-BCArtifactUrl -country base # Use base for test data
# $artifactUrl = Get-BCArtifactUrl -version 18.1 -type OnPrem -country w1 -select Latest
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

Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV Language Module_6.0.0.2087.app' -containerName $containerName -skipVerification 
Sync-BcContainerApp -appName "ForNAV Language Module" -Force -containerName $containerName
Install-BcContainerApp -appName "ForNAV Language Module" -containerName $containerName

Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV Core_6.0.0.2087.app' -containerName $containerName -skipVerification 
Sync-BcContainerApp -appName "ForNAV Core" -Force -containerName $containerName
Install-BcContainerApp -appName "ForNAV Core" -containerName $containerName

Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV_Customizable Report Pack_6.0.0.2.app' -containerName $containerName -skipVerification 
Sync-BcContainerApp -appName "Customizable Report Pack" -Force -containerName $containerName
Install-BcContainerApp -appName "Customizable Report Pack" -containerName $containerName

Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV Service_6.0.0.2087.app' -containerName $containerName -skipVerification 
Sync-BcContainerApp -appName "ForNAV Service" -Force -containerName $containerName
Install-BcContainerApp -appName "ForNAV Service" -containerName $containerName
