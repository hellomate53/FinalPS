function getdata {
param ($outfile)

#let's set a content
set-Content -path C:\Users\adbeeb\Desktop\fileFinal.txt -value "Info `n "  #if seeing data (test)

#add content
#= Get-WmiObject Win32_ComputerSystem
#echo $env:COMPUTERNAME >> $path
add-Content -path C:\Users\adbeeb\Desktop\fileFinal.txt -Value "computername: $env:COMPUTERNAME `r`n " #

$date = Get-Date
add-Content -path C:\Users\adbeeb\Desktop\fileFinal.txt -Value "Date/Time: $date `r`n " #
#echo $date >> $path

$OsVersion = Get-WmiObject -class Win32_OperatingSystem
add-Content -path C:\Users\adbeeb\Desktop\fileFinal.txt -value  "OS version: $OsVersion `r`n "
#echo $OsVersion >> $path

$s0 = Get-Process | where SessionId -eq 0 
#echo $s0 >> $path
$s1 = Get-Process | where SessionId -eq 1
#echo $s1 >> $path
add-Content -path C:\Users\adbeeb\Desktop\fileFinal.txt -Value "Session ID: $s0 `r`n " #print out the s'0 then print a new line 
add-Content -path C:\Users\adbeeb\Desktop\fileFinal.txt -Value "Session ID: $s1 `r`n " #and list s'1 

$sockets = Get-WmiObject Win32_Processor
add-Content -path C:\Users\adbeeb\Desktop\fileFinal.txt -Value "Socket: $sockets `r`n " 
#echo $sockets


}
{
#this function will hash DIRS
#function hashdir {
param(
[parameter(Mandatory=$true)] $dir,
[parameter(Mandatory=$false)]$outfile
)

$Foddir = Resolve-Path $dir
Get-ChildItem -Path $Foddir -Recurse | Get-FileHash > $outfile
echo "DIRECTORY HAS BEEN HASHED!!"
}


function customEx { #filter all the files based on (last access, Megabytes, or Name of the file)
Get-ChildItem -path C:\Users\adbeeb\ -ErrorAction silentlycontinue -Recurse | Sort-Object -Property length -Descending | Select-Object -property `
@{Label="Last access";Expression={($_.lastwritetime).ToshortDateString()}},
@{label="size in megabytes";Expression={"{0:N2}" -f ($_.Length / 1MB)}},
fullname 
 }

function TextToSpeech {
param([Parameter(Mandatory=$true)]
$Text, [switch]$Fast, [switch]$Slow)
$VoiceObject = New-Object -ComObject SAPI.SpVoice
if ($Slow) { $VoiceObject.Rate = -8 }
if ($Fast) { $VoiceObject.Rate = +3 }
$VoiceObject.Speak($text) | Out-Null}

TextToSpeech -Text "Hello mate!"
TextToSpeech -Text "Cool story bro!" -Slow
TextToSpeech -Text "how you doin" -Fast
