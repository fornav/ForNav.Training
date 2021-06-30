Import-Module BcContainerHelper

$artifactUrl = Get-BCArtifactUrl -country base # Use base for test data
$containerName = 'bc18-runtest'
$credential = New-Object pscredential 'admin', (ConvertTo-SecureString -String 'DS:P90*5JHY' -AsPlainText -Force)
$licenseFile = '.\BC18 On Prem ForNAV.flf'

New-BcContainer `
    -accept_eula `
    -containerName $containerName `
    -artifactUrl $artifactUrl `
    -Credential $credential `
    -auth UserPassword `
    -licenseFile $licenseFile `
    -updateHosts `
    -includeTestToolkit `
    -EnableTaskScheduler:$false

Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV Language Module_6.0.0.2087.app' -containerName $containerName -skipVerification 
Sync-BcContainerApp -appName "ForNAV Language Module" -Force -containerName $containerName
Install-BcContainerApp -appName "ForNAV Language Module" -containerName $containerName

Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV Core_6.0.0.2087.app' -containerName $containerName -skipVerification 
Sync-BcContainerApp -appName "ForNAV Core" -Force -containerName $containerName
Install-BcContainerApp -appName "ForNAV Core" -containerName $containerName

Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV_Customizable Report Pack_6.0.0.2.app' -containerName $containerName -skipVerification 
Sync-BcContainerApp -appName "Customizable Report Pack" -Force -containerName $containerName
Install-BcContainerApp -appName "Customizable Report Pack" -containerName $containerName

# Publish-BcContainerApp -packageType Extension -appFile '.\ForNAV Service_6.0.0.2087.app' -containerName $containerName -skipVerification 
# Sync-BcContainerApp -appName "ForNAV Service" -Force -containerName $containerName
# Install-BcContainerApp -appName "ForNAV Service" -containerName $containerName

Publish-BcContainerApp -packageType Extension -appFile '.\<your app file>' -containerName $containerName -skipVerification 
Sync-BcContainerApp -appName "<your app name>" -Force -containerName $containerName
Install-BcContainerApp -appName "<your app name>" -containerName $containerName

Publish-BcContainerApp -packageType Extension -appFile '.\<your app testfile>' -containerName $containerName -skipVerification 
Sync-BcContainerApp -appName "<your test app name>" -Force -containerName $containerName
Install-BcContainerApp -appName "<your test app name>" -containerName $containerName

Run-TestsInNavContainer -containerName $containerName -credential $credential -detailed -testSuite '<your test suite name>'