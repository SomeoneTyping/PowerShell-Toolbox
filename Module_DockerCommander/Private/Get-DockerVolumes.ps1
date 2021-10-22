function Get-DockerVolumes {

    process {

        $allDockerVolumes = docker volume ls --format "{{.Driver}}\t{{.Name}}\t{{.Scope}}\t{{.Mountpoint}}\t{{.Labels}}\t" | ConvertFrom-CSV -Delimiter "`t" -Header ("Driver","Name","Scope","Mountpoint","Labels")

        return $allDockerVolumes
    }
}
