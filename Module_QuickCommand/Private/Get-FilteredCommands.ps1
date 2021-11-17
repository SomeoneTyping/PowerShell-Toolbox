function Get-FilteredCommands {

    param (
        [Parameter( Mandatory , ValueFromPipeline )]
        [ValidateNotNullOrEmpty()]
        $CommandEntry
    )

    process {

        if ((-not $CommandEntry) -or (-not $CommandEntry.criteriaModus)) {
            return Out-Null -InputObject $CommandEntry
        }

        if ($CommandEntry.criteriaModus -eq "FolderContains") {
            if (Test-Path $CommandEntry.criteria) {
                return $CommandEntry
            }
        }

        if ($CommandEntry.criteriaModus -eq "PathEndsWith") {
            $bsNeutralerPfad = $CommandEntry.criteria.Replace("/", " ").Replace("\", " ").Trim()
            $aktuellerPfad = (Get-Location).Path
            $bsNeutralerPointerPfad = $aktuellerPfad.Replace("/", " ").Replace("\", " ").Trim()
            if ($bsNeutralerPointerPfad.EndsWith($bsNeutralerPfad)) {
                return $CommandEntry
            }
        }

        return Out-Null -InputObject $CommandEntry
    }
}