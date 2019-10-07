function Remove-CsvValue {
<#
    .SYNOPSIS
    [CSV] Löscht in der übergebenen CSV-Datei Einträge, die den übergebenen Wert haben. Die Suche ist nicht case-sensitive.
#>

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
