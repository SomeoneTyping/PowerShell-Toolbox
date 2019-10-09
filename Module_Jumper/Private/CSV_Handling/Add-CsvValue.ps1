<#
    .SYNOPSIS
    Adds in a given *.csv-file a new entry defined by a given PSObject
#>
function Add-CsvValue {

    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path,

        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [PsObject]
        $PsObject
    )

    process {

        Write-Debug "[Add-CsvValue] Path: '$Path'"
        $PsObject | Export-Csv -Path $Path -Delimiter "," -Append -NoTypeInformation
    }
}
