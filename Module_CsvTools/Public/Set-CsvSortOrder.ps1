<#
    .SYNOPSIS
    Searches in a given *.csv-file for entries that contain a given value under a given key.
    When the file does not exists, it returns $null.
#>
function Set-CsvSortOrder {

    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path,

        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Key,

        [Switch]
        $Descending
    )

    process {

        Write-Debug "[Set-CsvSortOrder] Path: $Path, Key: $Key, Descending: $Descending"

        if (-not (Test-Path $Path)) {
            return $null
        }

        $table = Import-Csv -Delimiter "," -Path $Path

        if ($Descending.IsPresent) {
            $table = $table | Sort-Object { $_.$Key } -Descending
        } else {
            $table = $table | Sort-Object { $_.$Key }
        }

        $table | Export-Csv -Path $Path -Delimiter "," -NoTypeInformation
    }
}
