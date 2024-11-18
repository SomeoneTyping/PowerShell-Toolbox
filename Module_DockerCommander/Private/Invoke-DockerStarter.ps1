function Invoke-DockerStarter {

    process {

        # 1. Get all running containers
        $allRunngingContainer = Get-DockerPsA | Where-Object { $_.Status.Contains("Exited ") }

        if (-not $allRunngingContainer) {
            Write-Host "No container is running"
            return
        }

        foreach ($container in $allRunngingContainer) {
            Write-Host ([string]::Format("Starting container {0}", $container.Name))
            docker start $container.ID
        }
    }
}
