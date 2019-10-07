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

        [switch]
        $Remove
    )

    begin {
        Set-StrictMode -Version 3
    }

    process {

        $tagValidated = if ($Tag) { $Tag.ToLower() } else { "*" }
        $pathesFile = Get-FileLocationPathesCsv

        $resultsForContainsSearch = Get-CsvValues -Path $pathesFile -Key "tag" -ValueContains $tagValidated
        if (-not $resultsForContainsSearch) {
            Write-Host ([string]::Format("No results found for request '{0}'", $Tag)) -ForegroundColor Red
            return
        }

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
        }

        if ($Remove.IsPresent) {
            $resultsForContainsSearch | ForEach-Object { $color = if (Test-Path $_.path) { "White" } else { "Yellow" }; Write-InfoLine $_.tag $_.path -space 18 -color $color }
            $resultCount = ($resultsForContainsSearch | Measure-Object).Count
            $input = Read-Host ([string]::Format("Remove these {0} entries? [J/N]", $resultCount))
            if ($input -eq "j") {
                foreach($entry in $resultsForContainsSearch) {
                    Remove-CsvValue -Path $pathesFile -Key "tag" -Value $entry.tag
                }
            }
            return
        }

        if ($List.IsPresent) {
            $resultsForContainsSearch | ForEach-Object { $color = if (Test-Path $_.path) { "White" } else { "Yellow" }; Write-InfoLine $_.tag $_.path -space 18 -color $color }
            return
        }

        $firstPathEntry = $resultsForContainsSearch | Where-Object { (Test-Path $_.path) } | Select-Object -First 1
        if (-not $firstPathEntry) {
            Write-Host ([string]::Format("No existing pathes for request '{0}'", $Tag)) -ForegroundColor Red
            return
        }

        Set-Location $firstPathEntry.path
    }
}
