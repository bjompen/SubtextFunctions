$ErrorActionPreference = "Stop"

# Get relevant script files
$Classes = Get-ChildItem "$PSScriptRoot\Classes" -ErrorAction SilentlyContinue -Filter *.ps1
$Public  = Get-ChildItem "$PSScriptRoot\Public"  -ErrorAction SilentlyContinue -Filter *.ps1
$Private = Get-ChildItem "$PSScriptRoot\Private" -ErrorAction SilentlyContinue -Filter *.ps1

# import classes
foreach($class in $Classes) {
    try{
        . $class.fullname
    }
    catch{
        Write-Error -Message "Failed to import class $($class.fullname): $_"
    }    
}

# dot source the functions
foreach($import in @($Public;$Private))
{
    try{
        . $import.fullname
    }
    catch{
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# export public members
Export-ModuleMember -Function $Public.BaseName
