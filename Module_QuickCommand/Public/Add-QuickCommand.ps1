function Add-QuickCommand {
<#
    .SYNOPSIS
    Suggests commands depending on predefined ruleset in the configurations folder
#>
    param (
        [ValidateNotNullOrEmpty()]
        [string]
        $Command,

        [ValidateNotNullOrEmpty()]
        [string]
        $Description,

        [string]
        $FolderContains,

        [string]
        $PathEndsWith
    )

    process {

        if ([string]::IsNullOrEmpty($FolderContains) -and [string]::IsNullOrEmpty($PathEndsWith)) {
            Write-Error "Please provide a criteria 'FolderContains' with a file name or 'PathEndsWith' with a sub path"
            return
        }

        if ((-not [string]::IsNullOrEmpty($FolderContains)) -and (-not [string]::IsNullOrEmpty($PathEndsWith))) {
            Write-Error "Please provide only one criteria 'FolderContains' OR 'PathEndsWith'."
            return
        }

        #"command","description","criteriaModus","criteria"
        $newQuickCommand = New-Object PsObject
        Add-Member -InputObject $newQuickCommand -Name "command" -Value $Command -MemberType NoteProperty
        Add-Member -InputObject $newQuickCommand -Name "description" -Value $Description -MemberType NoteProperty
        Add-Member -InputObject $newQuickCommand -Name "criteriaModus" -Value "" -MemberType NoteProperty
        Add-Member -InputObject $newQuickCommand -Name "criteria" -Value "" -MemberType NoteProperty
        if (-not [string]::IsNullOrEmpty($FolderContains)) {
            $newQuickCommand.criteriaModus = "FolderContains"
            $newQuickCommand.criteria = $FolderContains
        }
        if (-not [string]::IsNullOrEmpty($PathEndsWith)) {
            $newQuickCommand.criteriaModus = "PathEndsWith"
            $newQuickCommand.criteria = $PathEndsWith
        }
        $pathCommandsCsv = Get-FileLocationCommandsCsv
        Add-CsvValue -Path $pathCommandsCsv -PsObject $newQuickCommand
    }
}
