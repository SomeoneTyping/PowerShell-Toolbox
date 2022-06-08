function Get-DockerImages {

    process {

        $allDockerImages = docker image ls --format "{{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Digest}}\t{{.CreatedSince}}\t{{.CreatedAt}}\t{{.Size}}" | ConvertFrom-CSV -Delimiter "`t" -Header ("Id","Repository","Tag","Digest","CreatedSince","CreatedAt","Size")

        # Compute and write size normalized in MB
        foreach ($current in $allDockerImages) {
            $sizeInMb = $current.Size
            if ($sizeInMb.Contains("MB") -and $sizeInMb.Contains(".")) {
                $index = $sizeInMb.IndexOf(".")
                $sizeInMb = $sizeInMb.Substring(0, $index)
            }
            $sizeInMb = $sizeInMb.Replace("MB", "")
            if ($sizeInMb.Contains("GB")) {
                $sizeInMb = $sizeInMb.Replace("GB", "0").Replace(".", "")
            }
            $sizeInteger = [int]$sizeInMb
            Add-Member -InputObject $current -Name "SizeMB" -Value $sizeInteger -MemberType NoteProperty
        }

        return $allDockerImages
    }
}
