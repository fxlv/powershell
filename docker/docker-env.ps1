if ( docker-machine ls | select-string -quiet -pattern dev11 ) {
	write-host "Docker machine is up, let me set it up for you."
	docker-machine.exe env --shell powershell dev11 | Invoke-Expression
} else {
	echo "Docker machine is down."
}