function Write-Header {

    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $headerText
    )

    process {

        $widthOfConsoleWindow = $Host.UI.RawUI.WindowSize.Width

        $line = "-" * $widthOfConsoleWindow

        $formatedHeaderText = [string]::Format(" {0} ", $headerText)
        $halfTextLength = [math]::Round($formatedHeaderText.Length/2)
        $fillLeft = [math]::Round($widthOfConsoleWindow/2) - $halfTextLength
        $fillRight = $widthOfConsoleWindow - $fillLeft - $formatedHeaderText.Length

        Write-Host "`n$line"
        Write-Host ("-" * $fillLeft) -NoNewline
        Write-Host $formatedHeaderText -NoNewline -ForegroundColor Blue
        Write-Host ("-" * $fillRight)
        Write-Host "$line`n"
    }
}