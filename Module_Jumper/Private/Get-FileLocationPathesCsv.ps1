function Get-FileLocationPathesCsv {

    $subPath = "/Configurations/pathes.csv"
    $moduleFolder = Split-Path -Path $PSScriptRoot -Parent
    $filePath = Join-Path -Path $moduleFolder -ChildPath $subPath

    return $filePath
}
