<#
    .SYNOPSIS
    Sucht in Modulen, Commands und Aliasen nach dem übergebenen Suchwort
#>
function Show-Command {

    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $searchString
    )

    process {

        $alreadyPrintedCommands = @()

        # Search for modules named like $searchString
        $moduleSearchResult = @( Get-Childitem function:\ | Where-Object { $_.Source.ToLower().Contains($searchString.ToLower()) })
        if ($moduleSearchResult) {
            $moduleName = ($moduleSearchResult | Select-Object -First 1).Source
            Write-Header "Module: $moduleName"
            foreach ($command in $moduleSearchResult) {
                Write-FullCommandInfo $command.Name
                $alreadyPrintedCommands += $command.Name
            }
        }

        # Search for command named like $searchString
        $commandSearchResult = @( Get-Childitem function:\ | Where-Object { $_.Name.ToLower().Contains($searchString.ToLower()) } ) | Where-Object { -not ($alreadyPrintedCommands -contains $_.Definition ) }
        if ($commandSearchResult) {
            Write-Header "Commands"
            foreach ($command in $commandSearchResult) {
                Write-FullCommandInfo $command.Name
                $alreadyPrintedCommands += $command.Name
            }
        }

        # Search in for aliases named like $searchString
        $aliasSearchResult = Get-Alias | Where-Object { $_.Name.ToLower().Contains($searchString.ToLower()) } | Where-Object { -not ($alreadyPrintedCommands -contains $_.Definition ) }
        if ($aliasSearchResult) {
            Write-Header "Aliases"
            foreach ($alias in $aliasSearchResult) {
                Write-FullCommandInfo $alias.Definition
                $alreadyPrintedCommands += $alias.Definition
            }
        }
    }
}