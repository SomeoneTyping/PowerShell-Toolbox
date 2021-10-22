function Get-DockerImages {

    process {

        $allDockerImages = docker image ls --format "{{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Digest}}\t{{.CreatedSince}}\t{{.CreatedAt}}\t{{.Size}}" | ConvertFrom-CSV -Delimiter "`t" -Header ("Id","Repository","Tag","Digest","CreatedSince","CreatedAt","Size")

        return $allDockerImages
    }
}
