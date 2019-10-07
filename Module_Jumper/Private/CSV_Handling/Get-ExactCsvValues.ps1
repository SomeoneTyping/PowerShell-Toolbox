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

        $table = Import-Csv -Delimiter "," -Path $Path
        if (-not $table) {
            return
        }

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
