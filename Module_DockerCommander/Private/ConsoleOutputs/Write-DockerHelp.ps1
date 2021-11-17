function Write-DockerHelp {

    process {

        Write-Host ""
        Write-Host "usage: dc [action]"
        Write-Host ""
        Write-Host "Actions:"
        Write-Host "  lumos                                  --> Show all active containers and all images"
        Write-Host "  stop                                   --> Stops all running containers"
        Write-Host "  clean [all|container|images|volumes]   --> Default: all. Removes unused containers, images and volumes."
        Write-Host "  jump                                   --> Jump per shell into a running container"
        Write-Host "`n"
    }
}
