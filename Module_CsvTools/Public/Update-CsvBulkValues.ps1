<#
    .SYNOPSIS
    Updates an csv-entry in a given *.csv-file.
#>
function Update-CsvBulkValues {

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
        $OldSubstring,

        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $NewSubstring
    )

    process {

        Write-Debug "[Update-CsvBulkValues] Path: $Path, Key: $Key, Value: $Value, Replace: $Replace"

        if (-not (Test-Path $Path)) {
            Write-Debug "[Update-CsvBulkValues] Path $Path does not exist"
            return
        }

        $table = Import-Csv -Delimiter "," -Path $Path
        $table = $table | ForEach-Object { $_.$Key = $_.$Key.Replace($Value, $Replace) ; return $_ }
        $table | Export-Csv -Path $Path -Delimiter "," -NoTypeInformation
    }
}
