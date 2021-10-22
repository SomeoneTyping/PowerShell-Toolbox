function Get-DockerPsA {

    process {

        $allDockerContainers = docker ps -a --no-trunc --format "{{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}\t{{.Command}}\t{{.CreatedAt}}\t{{.RunningFor}}\t{{.Mounts}}\t{{.Networks}}" | ConvertFrom-CSV -Delimiter "`t" -Header ("Id","Name","Status","Image","Ports","Command","CreatedAt","RunningFor","Mounts","Networks")

        return $allDockerContainers
    }
}
