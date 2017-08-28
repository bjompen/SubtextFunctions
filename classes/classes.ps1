class SubTextLine {
    [int]$line
    [timespan]$StartTime
    [timespan]$EndTime
    [timespan]$duration
    [string[]]$text

    SubTextLine ($line,$StartTime,$EndTime,$Text) {
        $this.line=$line
        $this.StartTime=$StartTime
        $this.EndTime=$EndTime
        $this.text=$Text
        $this.duration = $this.EndTime - $this.StartTime
    }

    [void]AddSeconds([int]$seconds) {
        $seconds = $seconds * 10000000
        $this.StartTime = $this.StartTime.Add($seconds)
        $this.EndTime = $this.EndTime.Add($seconds)
    }
    
    [void]AddMilliseconds([int]$Milliseconds) {
        $Milliseconds = $Milliseconds * 1000
        $this.StartTime = $this.StartTime.Add($Milliseconds)
        $this.EndTime = $this.EndTime.Add($Milliseconds)
    }

    [String]ToString() {
        Return "$($This.Line)`n$($This.StartTime) --> $($This.endTime)`n$($This.text)`n`n"
    }
}

class SubText {
    [SubTextLine[]]$Lines

    SubText ([SubTextLine]$lines) {
        foreach ($Line in $lines) { 
            $This.Lines += $line
        }
    }

    [void]AddSeconds([timespan]$seconds) {
        for ($i = 0; $i -lt $this.Lines.Length; $i++) {
            $this.Lines[$i].StartTime.Add($seconds)
            $this.Lines[$i].EndTime.Add($seconds)
        }
    }
}