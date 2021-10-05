<#
    .SYNOPSIS
    Jump to a folder on your computer
#>
function Enter-Folder {

    param (
        [Alias("to")]
        [string]
        $Tag,

        [string]
        $Add,

        [switch]
        $List,

        [string]
        $Remove
    )

    begin {
        Set-StrictMode -Version 3
    }

    process {

        $tagValidated = if ($Tag) { $Tag.ToLower() } else { "*" }
        $pathesFile = Get-FileLocationPathesCsv

        if ($Add) {
            $searchAddRequest = Get-ExactCsvValues -Path $pathesFile -Key "tag" -Value $Add
            if ($searchAddRequest) {
                $newPath = Get-Location
                Update-CsvValue -Path $pathesFile -WhereKeyName "tag" -WhereKeyValue $Add -ValueName "path" -NewValue $newPath
            } else {
                $currentLocation = Get-Location
                $newPathObject = New-PathObject -Tag $Add -Path $currentLocation
                Add-CsvValue -Path $pathesFile -PsObject $newPathObject
            }

            return
        }

        $resultsForContainsSearch = Get-CsvValues -Path $pathesFile -Key "tag" -ValueContains $tagValidated
        if (-not $resultsForContainsSearch) {
            Write-Host ([string]::Format("No results found for request '{0}'", $Tag)) -ForegroundColor Red
            return
        }

        if ($Remove) {
            $searchRemoveRequest = Get-CsvValues -Path $pathesFile -Key "tag" -Value $Remove
            $resultCount = ($searchRemoveRequest | Measure-Object).Count
            $userInput = Read-Host ([string]::Format("Remove these {0} entries? [J/N]", $resultCount))
            if ($userInput -eq "j") {
                foreach($entry in $searchRemoveRequest) {
                    Remove-CsvValue -Path $pathesFile -Key "tag" -Value $entry.tag
                }
            }
            return
        }

        if ($List.IsPresent) {
            $resultsForContainsSearch | ForEach-Object { $color = if (Test-Path $_.path) { "White" } else { "Yellow" }; Write-InfoLine $_.tag $_.path -space 18 -color $color }
            return
        }

        # Zero Results
        $resultCount = ($resultsForContainsSearch | Measure-Object).Count
        if ($resultCount -eq 0) {
            Write-Host ([string]::Format("No existing pathes for request '{0}'", $Tag)) -ForegroundColor Red
            return
        }

        # One Result
        if ($resultCount -eq 1) {
            $firstResult = $resultsForContainsSearch | Select-Object -First 1
            if (Test-Path $firstResult.path) {
                Set-Location $firstResult.path
            } else {
                Write-Host ([string]::Format("The path '{0}' is not available", $firstResult.path)) -ForegroundColor Yellow
            }
            return
        }

        # Multiple Results
        $counter = 1;
        foreach ($path in $resultsForContainsSearch) {
            $color = if (Test-Path $path.path) { "White" } else { "Yellow" }
            $tagText = $path.tag
            Write-InfoLine ("($counter) $tagText") $path.path -space 25 -color $color
            $counter++;
        }
        $userInput = Read-Host "Goto Path"
        if ($userInput -match "^[0-9]{1,2}$") {
            $inputAsNumber = ($userInput -as [int]) - 1
            $resultsForContainsSearch | Select-Object -Index $inputAsNumber | Set-Location
        }
    }
}
