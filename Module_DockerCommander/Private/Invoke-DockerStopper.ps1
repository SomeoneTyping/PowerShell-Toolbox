function Invoke-DockerStopper {

    process {

        # 1. Get all running containers
        $allRunngingContainer = Get-DockerPsA | Where-Object { $_.Status.Contains("Up ") }

        if (-not $allRunngingContainer) {
            Write-Host "No container is running"
            return
        }

        foreach ($container in $allRunngingContainer) {
            Write-Host ([string]::Format("Stopping container {0}", $container.Name))
            docker stop $container.ID
        }
    }
}
