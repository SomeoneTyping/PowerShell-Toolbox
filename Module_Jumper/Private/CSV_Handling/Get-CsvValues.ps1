<#
    .SYNOPSIS
    Searches in a given *.csv-file for entries that contain a given value under a given key
#>
function Get-CsvValues {

    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path,

        [string]
        $Key,

        [Alias("value")]
        [string]
        $ValueContains
    )

    process {

        Write-Debug "[Get-CsvValues] Path: $Path, Key: $Key, ValueContains: $ValueContains"

        $table = Import-Csv -Delimiter "," -Path $Path
        if (-not $table) {
            return
        }

        if (-not ($Key -and $ValueContains)) {
            return $table
        }

        $selectedEntries = $table
        if ($ValueContains -ne "*") {
            $selectedEntries = $table | Where-Object { $_.$Key.ToLower().Contains($ValueContains.ToLower()) }
        }

        return $selectedEntries
    }
}
