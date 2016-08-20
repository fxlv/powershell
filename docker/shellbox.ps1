# Run a shellbox container
# mount resources directory from OneDrive and do it on both windows and osx

$localResourcesPath = false
$userName = $(whoami)

if (Test-Path /usr/bin/uname) {
    # this is likely unix
    # do stuff
    Write-Output "Running on OSX"
    $localResourcesPath = "/Users/$userName/OneDrive/opt/docker-scripts/resources"

} else {
    # this is likely windows
    Write-Output "Running on Windows"
    $localResourcesPath = "/c/Users/$userName/OneDrive/opt/docker-scripts/resources"
}

$cmd = "docker run -v $($localResourcesPath):/resources -t -i fxlv/debian_wheezy:shellbox bash"

Invoke-Expression $cmd