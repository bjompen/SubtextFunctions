$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

$SubTitle = '1
 00:00:22,000 --> 00:00:27,000
 Ill teach thee Bugology, Ignatzes

 2
 00:00:40,000 --> 00:00:43,000
 Something tells me

 3
 00:00:58,000 --> 00:01:59,000
 Look, Ignatz, a sleeping bee
 ' -split "`n"

Describe "ConvertFrom-Subtitle" {
    It "does something useful" {
        $true | Should Be $false
    }
}
