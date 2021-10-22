function Invoke-DockerCleaner {

    param (
        [ValidateSet("all","container","images","volumes")]
        [string]
        $Option
    )

    process {

        if (($Option -eq "all") -or ($Option -eq "container")) {
            Write-Headline "Removing exited containers"

            $allExitedContainer = Get-DockerPsA | Where-Object { $_.Status.Contains("Exited ") }
            foreach ($container in $allExitedContainer) {
                docker rm $container.id
            }
        }

        if (($Option -eq "all") -or ($Option -eq "images")) {
            Write-Headline "Removing untagged images"

            $allUntaggedImages = Get-DockerImages | Where-Object { $_.Tag -eq "<none>" }
            foreach ($image in $allUntaggedImages) {
                docker rmi $image.id
            }
        }

        if (($Option -eq "all") -or ($Option -eq "volumes")) {
            Write-Headline "Removing unused volumes"

            docker volume prune -f
        }
    }
}
