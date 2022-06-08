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

        $allImages = Get-DockerImages | Sort-Object -Property @{Expression = "SizeMB"; Descending = $true}
        Write-Headline "Docker Images"
        if ($allImages) {
            foreach ($image in $allImages) {
                Write-Host ([string]::Format("{0} MB  {1}:{2}", $image.SizeMB.ToString().PadLeft(5), $image.Repository, $image.Tag, $image.Size))
            }
        }

        Write-Host "`n"
    }
}
