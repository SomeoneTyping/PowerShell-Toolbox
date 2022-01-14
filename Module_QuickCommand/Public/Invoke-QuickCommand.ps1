function Invoke-QuickCommand {
<#
    .SYNOPSIS
    Suggests commands depending on predefined ruleset in the configurations folder
#>

    process {

        # 1. Generiere die Befehlsliste
        $pathCommandsCsv = Get-FileLocationCommandsCsv
        $filteredCommands = Get-CsvValues -Path $pathCommandsCsv -Key "criteria" -ValueContains "*" | Get-FilteredCommands

        if (-not $filteredCommands) {
            Write-Host "No Commands available"
            return
        }

        # 2. Gebe die Liste aus und gebe eine Auswahlmöglichkeit
        $counter = 1
        foreach ($command in $filteredCommands) {
            Write-Host ([string]::Format(" {0} - ", $counter.ToString().PadLeft(2))) -NoNewline
            Write-Host $command.command -NoNewline -ForegroundColor Green
            Write-Host ([string]::Format(" | {0}", $command.description))

            $counter++
        }

        # 3. Lese Eingabe
        $input = Read-Host "Execute Number"
        if ($input -match "^[0-9]{1,2}$") {
            $inputAsNumber = ($input -as [int]) - 1
            $executionCommand = $filteredCommands | Select-Object -Index $inputAsNumber
            Invoke-Expression $executionCommand.command
        }
    }
}
