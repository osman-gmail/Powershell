<#
    .SYNOPSIS
      <Overview of script>
    .DESCRIPTION
      <Brief description of script>
    .PARAMETER <Parameter_Name>
        <Brief description of parameter input required. Repeat this attribute if required>
    .INPUTS
      <Inputs if any, otherwise state None>
    .OUTPUTS
      <Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>
    .NOTES
      Version:        1.0
      Author:         <Name>
      Creation Date:  <Date>
      Purpose/Change: Initial script development
  
    .EXAMPLE
      <Example goes here. Repeat this attribute for more than one example>
#>


#Set up functions

Function Check-LocalAdminGroup {
    param (
        [String]$computer,
        [pscredential]$cred
    )

    $SB = {
        $ADSIComputer = [ADSI]("WinNT://localhost,computer") 
        $group = $ADSIComputer.psbase.children.find('Administrators',  'Group') 
        $group.psbase.invoke("members")  | ForEach {
          $_.GetType().InvokeMember("Name",  'GetProperty',  $null,  $_, $null)
        }
    }

    $res = Invoke-Command -ComputerName $Computer -Credential $cred -ScriptBlock $SB

    if ($Computer.Substring(0,1) -eq "w") {
        return $res -contains "AGG-WindowsServer-All-Administrators"
    } elseif ($Computer.Substring(0,2) -eq "nt") {
        $res -contains "Server Admins"
    }
}



#Set up variables


$servers = get-content "list.txt"
$cred = Get-Credential


#Start Execution

"Server,DNS,PING,ADCHECK,Wsman-Auth,WMIAUTH,LocalGroup" | Out-File .\server-checks.csv -Force

foreach ($server in $servers`)
{
    $DNS = $null
    $PING = $null
    $ADCHECK = $null
#    $WSCHECK = $null
    $AUTHCHECK = $null
    $WMIAUTH = $null
    $LocalGroup = $null
    try {
        $DNS = [System.Net.Dns]::GetHostAddresses("$server").IPAddressToString 
        $PING = Test-Connection -ComputerName $server -Count 1 -Quiet
        $ADCHECK = Get-ADComputer $server -ErrorAction Stop | Select-Object Enabled
        $AUTHCHECK = Test-WSMan $server -Authentication Default -Credential $cred | Select-Object ProductVersion
        $WMIAUTH = Get-WmiObject -Class Win32_ComputerSystem -Credential $cred -ComputerName $server | Select-Object Name
        $LocalGroup = Check-LocalAdminGroup -computer $server -cred $cred
    }
    catch {
    }
    Write-host $Server "," $DNS ","$PING "," $ADCHECK "," $AUTHCHECK "," $WMIAUTH "," $LocalGroup
    "$Server,$DNS,$PING,$ADCHECK,$AUTHCHECK,$WMIAUTH,$LocalGroup" | Out-File .\server-checks.csv -Append
  
}