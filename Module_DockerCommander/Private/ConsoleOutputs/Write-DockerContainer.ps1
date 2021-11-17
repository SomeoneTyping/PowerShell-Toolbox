function Write-DockerContainer {

    [CmdletBinding()]
    param (
        [Parameter( Mandatory )]
        [string]
        $Name,

        [Parameter( Mandatory )]
        [string]
        $Id,

        [Parameter( Mandatory )]
        [string]
        $Image,

        [Parameter( Mandatory )]
        [string]
        $Status,

        [string]
        $Ports
    )

    process {

        Write-Host ([string]::Format("  {0}", $Name.PadRight(20))) -ForegroundColor Green -NoNewline
        Write-Host "Id: " -ForegroundColor DarkGray -NoNewline
        Write-Host $Id.Substring(0,4).PadRight(8) -ForegroundColor White -NoNewline
        Write-Host "Status: " -ForegroundColor DarkGray -NoNewline
        Write-Host $Status.PadRight(32) -ForegroundColor White -NoNewline
        Write-Host "Image: " -ForegroundColor DarkGray -NoNewline
        Write-Host $Image -ForegroundColor White -NoNewline
        if ($Ports) {
            Write-Host "    Ports: " -ForegroundColor DarkGray -NoNewline
            Write-Host $Ports -ForegroundColor White -NoNewline
        }
        Write-Host ""
    }
}
