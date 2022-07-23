function Remove-QuickCommand {
<#
    .SYNOPSIS
    Suggests commands depending on predefined ruleset in the configurations folder
#>
    param (
        [string]
        $Command
    )

    process {

        $pathCommandsCsv = Get-FileLocationCommandsCsv
        $allCommands = Get-CsvValues -Path $pathCommandsCsv -Key "criteria" -ValueContains "*"

        if ($Command) {
            $allCommands = $allCommands | Where-Object { $_.command.ToLower().Contains($Command.ToLower()) }
        }

        # Write list of commands and show selection
        $counter = 1
        foreach ($command in $allCommands) {
            Write-Host ([string]::Format(" {0} - ", $counter.ToString().PadLeft(2))) -NoNewline
            Write-Host $command.command -NoNewline -ForegroundColor Green
            Write-Host ([string]::Format(" | {0}", $command.description))

            $counter++
        }

        # Read selected command
        $input = Read-Host "Remove Command With Number"
        if ($input -match "^[0-9]{1,2}$") {
            $inputAsNumber = ($input -as [int]) - 1
            $executionCommand = $allCommands | Select-Object -Index $inputAsNumber
            Remove-CsvValue -Path $pathCommandsCsv -Key "command" -Value $executionCommand.command
        }
    }
}
