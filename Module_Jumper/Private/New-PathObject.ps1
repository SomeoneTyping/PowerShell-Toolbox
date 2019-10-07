function New-PathObject {

    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Tag,

        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    process {

        $psObject = New-Object PsObject

        Add-Member -InputObject $psObject -Name "Tag" -Value $Tag -MemberType NoteProperty
        Add-Member -InputObject $psObject -Name "Path" -Value $Path -MemberType NoteProperty

        return $psObject
    }
}