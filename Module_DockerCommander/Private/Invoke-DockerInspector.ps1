function Invoke-DockerInspector {

    param (
        [ValidateSet("all","c","i")]
        [string]
        $Option
    )

    process {

        # 1. Get all running containers
        if (($Option -eq "all") -or ($Option -eq "c")) {
            $allContainers = Get-DockerPsA
            Write-Headline "Active Docker Containers"
            if ($allContainers) {
                foreach ($container in $allContainers) {
                    Write-DockerContainer -Name $container.Name -Id $container.ID -Image $container.Image -Status $container.Status -Ports $container.Ports
                    $counter++;
                }
            }
        }

        if (($Option -eq "all") -or ($Option -eq "i")) {
            $allImages = Get-DockerImages | Sort-Object -Property @{Expression = "SizeMB"; Descending = $true}
            Write-Headline "Docker Images"
            if ($allImages) {
                foreach ($image in $allImages) {
                    Write-Host ([string]::Format("{0} MB  {1}  ", $image.SizeMB.ToString().PadLeft(5), $image.Id.ToString().SubString(0, 5))) -NoNewline
                    Write-Host $image.Repository -ForegroundColor Green -NoNewline
                    Write-Host ([string]::Format(":{0}", $image.Tag))
                }
            }
        }

        Write-Host "`n"
    }
}
