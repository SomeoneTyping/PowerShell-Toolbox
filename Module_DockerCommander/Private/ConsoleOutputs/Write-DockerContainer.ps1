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

        $colorName = if ($Status.Contains("Up")) { "Green" } else { "Yellow" }
        Write-Host ([string]::Format("  {0}", $Name.PadRight(20))) -ForegroundColor $colorName -NoNewline
        Write-Host "Id: " -ForegroundColor DarkGray -NoNewline
        Write-Host $Id.Substring(0,4).PadRight(8) -ForegroundColor White -NoNewline
        Write-Host "Status: " -ForegroundColor DarkGray -NoNewline
        Write-Host $Status.PadRight(32) -ForegroundColor White

        if ($Ports) {
            Write-Host ([string]::Format("{0}  Ports: ", "".PadRight(20))) -ForegroundColor DarkGray -NoNewline
            Write-Host $Ports -ForegroundColor White
        }

        Write-Host ([string]::Format("{0}  Image: ", "".PadRight(20))) -ForegroundColor DarkGray -NoNewline
        Write-Host $Image -ForegroundColor White -NoNewline

        Write-Host ""
    }
}
