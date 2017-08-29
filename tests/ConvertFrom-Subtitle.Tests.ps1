$ModuleName = 'SubtextFunctions'
Get-Module $ModuleName | Remove-Module -Force
$ModuleBase = Split-Path $PSScriptRoot
Import-Module "$ModuleBase\SubtextFunctions.psm1" -Force

$SimpleSubTitle = '1
 00:00:22,000 --> 00:00:27,000
 Ill teach thee Bugology, Ignatzes

 2
 00:00:40,000 --> 00:00:43,000
 Something tells me

 3
 00:00:58,000 --> 00:01:59,000
 Look, Ignatz, a sleeping bee
 ' -split "`n"
$HarderSubTitle = '1
 00:00:22,000 --> 00:00:27,000
 Ill teach thee Bugology, Ignatzes
 Ill teach thee Bugology, Ignatzes

 2
 00:00:40,000 --> 00:00:43,000
 Something tells me
 Ill teach thee Bugology, Ignatzes

 3
 00:00:58,000 --> 00:01:59,000
 Look, Ignatz, a sleeping bee
 ' -split "`n"
$ShittySubTitle = '
1

 00:00:22,000 --> 00:00:27,000

 Ill teach thee Bugology, Ignatzes
 Ill teach thee Bugology, Ignatzes

 2
 00:00:40,000 --> 00:00:43,000
 Something tells me
 Ill teach thee Bugology, Ignatzes

 3
 00:00:58,000 --> 00:01:59,000
 Look, Ignatz, a sleeping bee
 ' -split "`n"
$WrongFormatSubTitle = '
# strange header comment
1
 00:00:22,000 --> 00:00:27,000
 Ill teach thee Bugology, Ignatzes
 Ill teach thee Bugology, Ignatzes

 2
 00:00:40,000 --> 00:00:43,000
 Something tells me
 Ill teach thee Bugology, Ignatzes

 3
 00:00:58,000 --> 00:01:59,000
 Look, Ignatz, a sleeping bee
 ' -split "`n"


Describe 'ConvertFrom-Subtitle' {
    It 'Module should have loaded ok' {
        Get-Module $ModuleName | Should Not BeNullOrEmpty
    }

    Context 'Should work with simple subtitles' {
        $Sub = ConvertFrom-Subtitle -InputObject $SimpleSubTitle

        It 'Should be exactly 3 lines of subtext' { 
            $Sub.Lines.Length | Should BeExactly 3
        }
        
        It 'Should be of type SubText' { 
            $sub.GetType().Name | Should Be 'SubText'
        }
        0..2 | Foreach {
            It "Line $_ should be correct" { 
                $sub.Lines[$_].GetType().Name | Should Be 'SubTextLine'
                $Sub.Lines[$_].Line | Should BeExactly ($_+1)
                $sub.Lines[$_].StartTime.GetType().Name | Should Be 'TimeSpan'
                $sub.Lines[$_].EndTime.GetType().Name | Should Be 'TimeSpan'
                $sub.Lines[$_].text | Should Not BeNullOrEmpty

            }
        }
    }

    Context 'Should work with harder subtitles' {
        $Sub = ConvertFrom-Subtitle -InputObject $HarderSubTitle

        It 'Should be exactly 3 lines of subtext' { 
            $Sub.Lines.Length | Should BeExactly 3
        }
        
        It 'Should be of type SubText' { 
            $sub.GetType().Name | Should Be 'SubText'
        }
        0..2 | Foreach {
            It "Line $_ should be correct" { 
                $sub.Lines[$_].GetType().Name | Should Be 'SubTextLine'
                $Sub.Lines[$_].Line | Should BeExactly ($_+1)
                $sub.Lines[$_].StartTime.GetType().Name | Should Be 'TimeSpan'
                $sub.Lines[$_].EndTime.GetType().Name | Should Be 'TimeSpan'
                $sub.Lines[$_].text | Should Not BeNullOrEmpty

            }
        }
    }

    Context 'Should not work with shitty or bad format subtitles' {
        It 'Should throw with wrong spacing in subtext' {
            {ConvertFrom-Subtitle -inputObject $ShittySubTitle} | Should Throw
        }
        
        It 'Should throw with wrong spacing in subtext' {
            {ConvertFrom-Subtitle -inputObject $WrongFormatSubTitle} | Should Throw
        }
    }
}
