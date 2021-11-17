function Invoke-DockerInspector {

    process {

        # 1. Get all running containers
        $allContainers = Get-DockerPsA
        Write-Headline "Active Docker Containers"
        if ($allContainers) {
            foreach ($container in $allContainers) {
                Write-DockerContainer -Name $container.Name -Id $container.ID -Image $container.Image -Status $container.Status -Ports $container.Ports
                $counter++;
            }
        }

        $allImages = Get-DockerImages
        Write-Headline "Docker Images"
        if ($allImages) {
            foreach ($image in $allImages) {
                Write-Host $image.Repository $image.Tag
            }
        }

        Write-Host "`n"
    }
}
