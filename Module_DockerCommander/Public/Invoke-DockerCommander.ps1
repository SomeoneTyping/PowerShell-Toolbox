function Invoke-DockerCommander {

    param (
        [ValidateSet("clean", "jump", "lumos", "stop", "start")]
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
                Invoke-DockerJumper
            }
            lumos {
                $parameterWithDefault = if ($Parameter) { $Parameter } else { "all" }
                Invoke-DockerInspector $parameterWithDefault
            }
            stop {
                Invoke-DockerStopper
            }
            start {
                Invoke-DockerStarter
            }
        }
    }
}
