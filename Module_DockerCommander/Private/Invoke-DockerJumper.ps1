function Invoke-DockerJumper {

    process {

        # 1. Get all running containers
        $allRunngingContainer = Get-DockerPsA | Where-Object { $_.Status.Contains("Up ") }

        if (-not $allRunngingContainer) {
            Write-Host "No container is running"
            return
        }

        # Case: Only one container is up
        if ($allRunngingContainer.Length -eq 1) {
            $oneContainer = $allRunngingContainer | Select-Object -First 1
            Write-Host ([string]::Format("Only one container is up: {0}. Jump!", $oneContainer.Name))
            docker exec -ti $oneContainer.Id "/bin/bash"
            return
        }

        $counter = 1
        foreach ($container in $allRunngingContainer) {
            Write-Host "  $counter) " -NoNewLine
            Write-DockerContainer -Name $container.Name -Id $container.ID -Image $container.Image -Status $container.Status -Ports $container.Ports
            $counter++;
        }
        $userInput = Read-Host "Jump into container"
        if ($userInput -match "^[0-9]{1,2}$") {
            $inputAsNumber = ($userInput -as [int]) - 1
            $selectedContainer = $allRunngingContainer | Select-Object -Index $inputAsNumber
            if ($selectedContainer) {
                $hasBash = docker exec -it $selectedContainer.Id sh -c "test -e /bin/bash && echo 'true'"
                if ($hasBash) {
                    Write-Host "Container has bash --> Jump!"
                    docker exec -ti $selectedContainer.Id "/bin/bash"
                } else {
                    Write-Host "Container has sh --> Jump!"
                    docker exec -ti $selectedContainer.Id "/bin/sh"
                }
            }
        }
    }
}
