function ConvertFrom-Subtitle
{
    [CmdletBinding()]
    [OutputType([psobject])]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $InputObject
    )

    Begin
    {
        [int]$Length        = $InputObject.Length - 1
        [int]$ReadLentgh    = 0
        [TimeSpan]$TimeSpan = New-TimeSpan

    }
    Process
    {
        do
        {
            [int]$ReadLine      = $ReadLentgh
            [int]$TimeLine      = $ReadLentgh + 1
            [int]$TextStartLine = $ReadLentgh + 2
            
            $x = $TextStartLine
            DO {
                $x++
            } 
            While (
                $InputObject[$x] -ne ''
            ) 
            [int]$TextEndLine   = $x - 1
                             

            $startTime = ((($InputObject[($TimeLine)] -replace ',','.').Replace(' ','')) -split '-->' )[0]
            $EndTime   = ((($InputObject[($TimeLine)] -replace ',','.').Replace(' ','')) -split '-->' )[1]
            $Text      = $inputObject[$TextStartLine..$textEndLine]

            [array]$Output += [SubTextLine]::new($($InputObject[$ReadLine]),$startTime,$EndTime,$Text)
            <#[array]$Output += New-Object -TypeName psobject -Property @{
                'Line'      = [int]$InputObject[$ReadLine]
                'StartTime' = [timespan]$startTime
                'EndTime'   = [timespan]$EndTime
                'Duration'  = [timespan]$Duration
                'text'      = [string[]]$Text
            }#>

            $ReadLentgh = $x + 1
            Write-Verbose "TextEndLine: $TextEndLine"
            Write-Verbose "Length: $Length"
        }
        until (($TextEndLine + 2) -ge $Length)
        
    }
    End
    {
        $Output
    }
}
