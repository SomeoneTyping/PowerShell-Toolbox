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

        $newGuid = [System.Guid]::NewGuid().ToString()
        $user = $env:PS_USER

        Add-Member -InputObject $psObject -Name "id" -Value $newGuid -MemberType NoteProperty
        Add-Member -InputObject $psObject -Name "tag" -Value $Tag -MemberType NoteProperty
        Add-Member -InputObject $psObject -Name "user" -Value $user -MemberType NoteProperty
        Add-Member -InputObject $psObject -Name "path" -Value $Path -MemberType NoteProperty

        return $psObject
    }
}