function Invoke-QuickCommand {
<#
    .SYNOPSIS
    Suggests commands depending on predefined ruleset in the configurations folder
#>
    param (
        [Alias("s")]
        [string]
        $Search
    )

    process {

        # Get all available commands
        $pathCommandsCsv = Get-FileLocationCommandsCsv
        $allCommands = Get-CsvValues -Path $pathCommandsCsv -Key "criteria" -ValueContains "*"

        if (-not [string]::IsNullOrEmpty($Search)) {
            # Modus: Search in commands
            $allCommands = $allCommands | Where-Object { $_.command.ToLower().Contains($Search.ToLower()) }
        } else {
            # Modus: List suggested commands
            $allCommands = $allCommands | Get-FilteredCommands
        }

        if (-not $allCommands) {
            Write-Host "No Commands available"
            return
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
        $input = Read-Host "Execute Number"
        if ($input -match "^[0-9]{1,2}$") {
            $inputAsNumber = ($input -as [int]) - 1
            $executionCommand = $allCommands | Select-Object -Index $inputAsNumber
            Invoke-Expression $executionCommand.command
        }
    }
}
