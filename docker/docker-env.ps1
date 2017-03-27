if ( -not (Get-Command docker-machine.exe | Select-String docker-machine.exe -q)) {
    write-host -ForegroundColor red  "docker-machine.exe not found. Do you have it installed?"
    exit
}

function vm_is_running {
	docker-machine.exe status default | Select-String -Pattern Running -Quiet
}

function start-vm {
	Write-Host "Starting VM..."
	docker-machine.exe start default
	if (vm_is_running) {
		Write-Host "VM started up successfully" -ForegroundColor Green
	} else {
		Write-Host -ForegroundColor Red "VM failed to start"
	}
}

function setup_environment {
	docker-machine.exe env --shell powershell default | Invoke-Expression
}

# look for VM named "default" and check if its state is "Running"
# if machine is found but it's not running, start it up
if ( docker-machine ls | select-string -Pattern default -quiet ) {
	write-host "Docker machine found" -ForegroundColor Green
	if ( vm_is_running ){
		Write-Host "Docker machine is running, will set up environment for you"
		setup_environment
		Write-Host "All done"
	} else {
		Write-Host "Docker machine is not running, will try to start it up" -ForegroundColor Yellow
		start-vm
		setup_environment
	}
	
} else {
	write-output "Docker machine is missing."
}