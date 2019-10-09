<#
    .SYNOPSIS
    Searches in a given *.csv-file for entries that are equal the given value under a given key.
    When the file does not exists, it returns $null.
#>
function Get-ExactCsvValues {

    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path,

        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Key,

        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Value
    )

    process {

        Write-Debug "[Get-ExactCsvValue] Path: $Path, Key: $Key, Value: $Value"

        if (-not (Test-Path $Path)) {
            return $null
        }

        $table = Import-Csv -Delimiter "," -Path $Path

        if (-not ($Key -and $Value)) {
            return $table
        }

        $selectedEntries = $table
        if ($Value -ne "*") {
            $selectedEntries = $table | Where-Object { $_.$Key -ceq $Value }
        }

        return $selectedEntries
    }
}
