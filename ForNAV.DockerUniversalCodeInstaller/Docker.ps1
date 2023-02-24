$artifactUrl = Get-BCArtifactUrl -version 21 -type OnPrem -country us -select Latest
$containerName = 'bc210-uc'
# $containerName = 'bc210-upgrade'
# $containerName = 'bc210-dll'
$credential = New-Object pscredential 'admin', (ConvertTo-SecureString -String 'admin' -AsPlainText -Force)
$licenseFile = 'X:\Sync\Red and Bundle\Licenties\BC21 On Prem ForNAV + Own Objects.flf'
$ucInstallFolder = 'X:\Sync\Red and Bundle\Development\Source Code\Cust.ForNAV\ForNAV Docker Installer\UniversalCodeApp'

# $additionalParameters = @("--publish 9031:9030")

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
    # -additionalParameters $additionalParameters
    
#    -useSSL `

Add-FontsToBCContainer -containerName $containerName -path c:\windows\fonts\*.ttf

docker stop $containerName
$dest = "{0}:\{1}" -f $containerName, 'ForNAVUC'
docker cp $ucInstallFolder $dest
# docker run --rm -it $containerName