#----------------------------------------------------------------------------------------
# Author: Konrad Daleske
# Modul: QuickCommand
#----------------------------------------------------------------------------------------

$PublicFunctions = @( Get-ChildItem -Path "$PSScriptRoot/Public/*.ps1" -Recurse -Exclude "*Tests*" -ErrorAction SilentlyContinue )
$PrivateFunctions = @( Get-ChildItem -Path "$PSScriptRoot/Private/*.ps1" -Recurse -Exclude "*Tests*" -ErrorAction SilentlyContinue )

# Binde die Funktionen ein
foreach ($file in @($PublicFunctions + $PrivateFunctions)) {
    try {
        . $file.FullName
    }
    catch {
        $exception = ([System.ArgumentException]"Function not found")
        $errorId = "Load.Function"
        $errorCategory = 'ObjectNotFound'
        $errorTarget = $file
        $errorItem = New-Object -TypeName System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $errorTarget
        $errorItem.ErrorDetails = "Failed to import function $($file.BaseName)"
        throw $errorItem
    }
}

# Some Convenience Aliases
Set-Alias -Name Quick   -Value Invoke-QuickCommand
Set-Alias -Name HelpMe  -Value Show-Command

Export-ModuleMember -Function $PublicFunctions.BaseName -Alias *
