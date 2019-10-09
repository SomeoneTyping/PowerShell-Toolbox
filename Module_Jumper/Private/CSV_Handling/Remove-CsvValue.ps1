<#
    .SYNOPSIS
    Removes an csv-entry in a given *.csv-file where a given key has a given value.
    Does nothing when the file does not exist.
#>
function Remove-CsvValue {

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

        Write-Debug "[Remove-CsvValue] Path: $path, Key: $key, Value: $value"

        if (-not (Test-Path $path)) {
            return
        }

        $table = Import-Csv -Delimiter "," -Path $path
        $table | Where-Object { $_.$key.ToLower() -ne $value.ToLower() } | Export-Csv -Path $path -Delimiter "," -NoTypeInformation
    }
}
