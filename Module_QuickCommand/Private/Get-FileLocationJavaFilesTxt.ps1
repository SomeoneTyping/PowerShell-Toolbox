function Get-FileLocationCommandsCsv {

    $subPath = "/Configurations/configurations.csv"
    $moduleFolder = Split-Path -Path $PSScriptRoot -Parent
    $filePath = Join-Path -Path $moduleFolder -ChildPath $subPath

    return $filePath
}
