#!/usr/local/bin/powershell
# Run a shellbox container
# mount resources directory from OneDrive and do it on both windows and osx
param(
    [string]$container = "shellbox" # shellbox it is by default
)

Write-Output "Running container: $container"

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

$cmd = "docker run -v $($localResourcesPath):/resources -t -i fxlv/debian_wheezy:$($container) bash"
Write-Output $cmd # debug purpose only

Invoke-Expression $cmd