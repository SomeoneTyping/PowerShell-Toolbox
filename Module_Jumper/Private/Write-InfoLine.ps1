function Write-InfoLine {

    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [Alias("left")]
        [string]
        $TextLeft,

        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [Alias("right")]
        [string]
        $TextRight,

        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [Alias("margin")]
        [int]
        $Space,

        [string]
        $Color
    )

    process {

        $colorValidated = if ($Color) { $Color } else { "White" }
        Write-Host ([string]::Format("  {0} - ", $TextLeft.PadRight($Space))) -NoNewline
        Write-Host $TextRight -ForegroundColor $colorValidated
    }
}
