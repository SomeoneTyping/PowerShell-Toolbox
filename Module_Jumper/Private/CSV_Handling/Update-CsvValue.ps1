function Update-CsvValue {

    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path,

        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $WhereKeyName,

        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $WhereKeyValue,

        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $ValueName,

        [string]
        $NewValue
    )

    process {

        Write-Debug "[Update-CsvValue] Path: $Path, WhereKeyName: $WhereKeyName, WhereKeyValue: $WhereKeyValue, ValueName: $ValueName, NewValue: $NewValue"

        if (-not (Test-Path $Path)) {
            return
        }

        $table = Import-Csv -Delimiter "," -Path $Path
        $table = $table | ForEach-Object { if ($_.$WhereKeyName -eq $WhereKeyValue.ToLower()) { $_.$ValueName = $NewValue ; return $_ } else { return $_ } }
        $table | Export-Csv -Path $Path -Delimiter "," -NoTypeInformation
    }
}
