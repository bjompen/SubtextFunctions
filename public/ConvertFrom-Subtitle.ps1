function ConvertFrom-Subtitle
{
    [CmdletBinding()]
    [OutputType([SubText])]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $InputObject
    )

    Begin
    {
        $InputObject = $InputObject.trim()
        [int]$Length        = $InputObject.Length - 1
        [int]$ReadLentgh    = 0

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

            Try { 
                [array]$Output += [SubTextLine]::new($($InputObject[$ReadLine]),$startTime,$EndTime,$Text)
            }
            Catch {
                Throw "Failed to Convert to SubTextLine: $_"
            }

            $ReadLentgh = $x + 1
        }
        until (($TextEndLine + 2) -ge $Length)
        
    }
    End
    {
        [SubText]::New($Output)
    }
}
