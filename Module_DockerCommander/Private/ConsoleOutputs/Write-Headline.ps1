function Write-Headline {

    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $headerText
    )

    process {

        $widthOfConsoleWindow = [math]::Round(($Host.UI.RawUI.WindowSize.Width) * 1.0)
        $formatedHeaderText = [string]::Format("{0} ", $headerText)
        $remainingLineLength = $widthOfConsoleWindow - $formatedHeaderText.Length

        $line = "-" * $remainingLineLength

        Write-Host ""
        Write-Host $formatedHeaderText -NoNewline -ForegroundColor Blue
        Write-Host $line
    }
}
