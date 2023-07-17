$artifactUrl = Get-BCArtifactUrl -version 22 -type OnPrem -country w1 -select Latest
$containerName = 'bc220-uc'
$credential = New-Object pscredential 'admin', (ConvertTo-SecureString -String 'admin' -AsPlainText -Force)
$licenseFile = './BC22 On Prem ForNAV.bclicense'
# Specify the path to your Universal Code installation foledr. This should contain the Universal Code app files, the ForNAV installer file, and your installation script.
$ucInstallFolder = './UniversalCodeApp'

New-BcContainer `
    -accept_eula `
    -containerName $containerName `
    -artifactUrl $artifactUrl `
    -Credential $credential `
    -auth UserPassword `
    -licenseFile $licenseFile `
    -updateHosts `
    -isolation hyperv `
    -EnableTaskScheduler:$true `
    -useGenericImage "$(Get-BestGenericImageName)-dev"

Add-FontsToBCContainer -containerName $containerName -path c:\windows\fonts\*.ttf

docker stop $containerName
$dest = "{0}:\{1}" -f $containerName, 'ForNAVUC'
docker cp $ucInstallFolder $dest
docker run --rm -it $containerName