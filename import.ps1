# This Script helps you to import all Modules here

function ImportModuleFromRelativePath([string]$relativePath, [string]$moduleName) {

    $absolutePath = Join-Path -Path $PSScriptRoot -ChildPath $relativePath

    Write-Host "  Module " -NoNewline
    Write-Host $moduleName -ForegroundColor Green -NoNewline
    Write-Host " ($absolutePath)" -ForegroundColor DarkGray

    Import-Module $absolutePath -Force
}

ImportModuleFromRelativePath "/Module_CsvTools/CsvTools.psm1" "CSV-Tools"
ImportModuleFromRelativePath "/Module_Jumper/Jumper.psm1" "Jumper"
ImportModuleFromRelativePath "/Module_QuickCommand/QuickCommand.psm1" "Quick-Command"

# You are tired of endlessly close and reopen your terminal just to reimport your default-modules?
# With these two lines you can just type "reload" to your commandline and it will reimport all modules,
# independent of your current working directory. Also works great when loading default-modules in your PS-profile
$pathToImportScript = Join-Path -Path $PSScriptRoot -ChildPath "import.ps1"
Set-Alias -Name Reload -Value $pathToImportScript -Scope Global