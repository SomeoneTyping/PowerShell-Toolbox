function Invoke-DockerCommander {

    param (
        [string]
        $Command,

        [string]
        $Parameter
    )

    process {

        if (-not $Command) {
            Write-DockerHelp
        }

        switch ($Command) {
            clean {
                $parameterWithDefault = if ($Parameter) { $Parameter } else { "all" }
                Invoke-DockerCleaner $parameterWithDefault
            }
            jump {
                # Springe in einen laufenden Container
                Invoke-DockerJumper
            }
            lumos {
                $parameterWithDefault = if ($Parameter) { $Parameter } else { "all" }
                Invoke-DockerInspector $parameterWithDefault
            }
            stop {
                Invoke-DockerStopper
            }
        }
    }
}
