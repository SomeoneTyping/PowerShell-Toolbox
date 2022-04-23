function Write-FullCommandInfo {

    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $commandName
    )

    process {

        $shortDescription = (Get-Help $commandName).Synopsis
        if ($shortDescription -and (-not $shortDescription.Contains($commandName))) {
            Write-Host ([string]::Format("  // {0}", $shortDescription.Replace("`n", ""))) -ForegroundColor DarkGray
        }

        # Print name of belonging module
        $command = Get-Command $commandName
        $moduleValidated = if ($command.Source) { $command.Source } else { "" }
        Write-Host ([string]::Format("  [{0}] ", $moduleValidated)) -ForegroundColor Blue -NoNewline

        # Print the command name
        Write-Host $commandName -ForegroundColor Yellow -NoNewline

        # Print aliases if there are any
        $aliases = (Get-Alias | Where-Object { $_.Definition -eq $commandName } | Select-Object -ExpandProperty Name) -join ", "
        if ($aliases) {
            Write-Host ([string]::Format(" (= {0})", $aliases)) -ForegroundColor DarkYellow -NoNewline
        }

        # Print all parameters with some extra Infos
        $parameters = $command.ParameterSets | Select-Object -ExpandProperty Parameters | Where-Object { -not ($_.Name -in [System.Management.Automation.PSCmdlet]::CommonParameters) }
        foreach ($parameter in $parameters) {
            switch ($parameter.ParameterType.ToString()) {
                "System.String" {
                    Write-Host ([string]::Format(" -{0}", $parameter.Name)) -ForegroundColor White -NoNewline
                    if ($parameter.IsMandatory) {
                        Write-Host "*" -ForegroundColor Red -NoNewline
                    }
                    Write-Host " [string]" -ForegroundColor DarkGray -NoNewline
                }
                "System.Int32" {
                    Write-Host ([string]::Format(" -{0}", $parameter.Name)) -ForegroundColor White -NoNewline
                    if ($parameter.IsMandatory) {
                        Write-Host "*" -ForegroundColor Red -NoNewline
                    }
                    Write-Host " [int]" -ForegroundColor DarkGray -NoNewline
                }
                "System.Management.Automation.SwitchParameter" {
                    Write-Host ([string]::Format(" (-{0})", $parameter.Name)) -ForegroundColor White -NoNewline
                }
                "System.String[]" {
                    Write-Host ([string]::Format(" -{0}", $parameter.Name)) -ForegroundColor White -NoNewline
                    if ($parameter.IsMandatory) {
                        Write-Host "*" -ForegroundColor Red -NoNewline
                    }
                    Write-Host " [string[]]" -ForegroundColor DarkGray -NoNewline
                }
                "System.Management.Automation.PSObject" {
                    Write-Host ([string]::Format(" -{0}", $parameter.Name)) -ForegroundColor White -NoNewline
                    if ($parameter.IsMandatory) {
                        Write-Host "*" -ForegroundColor Red -NoNewline
                    }
                    Write-Host " [PSObject]" -ForegroundColor DarkGray -NoNewline
                }
            }
        }

        Write-Host "`n"
    }
}