$srv = get-content "nt-server-list.txt"
#Check ports 5985, 5986
$cred = Get-Credential
"Server,DNS,PING,ADCHECK,Wsman-Auth,WMIAUTH" | Out-File .\server-checks.csv -Force
foreach ($server in $srv)
{
    $DNS = $null
    $PING = $null
    $ADCHECK = $null
    $WSCHECK = $null
    $AUTHCHECK = $null
    $WMIAUTH = $null
    try {
        $DNS = [System.Net.Dns]::GetHostAddresses("$server").IPAddressToString 
        $PING = Test-Connection -ComputerName $server -Count 1 -Quiet
        $ADCHECK = Get-ADComputer $server -ErrorAction Stop | Select-Object Enabled
#        $WSCHECK = Test-WSMan $server | Select-Object ProductVersion
        $AUTHCHECK = Test-WSMan $server -Authentication Default -Credential $cred | Select-Object ProductVersion
        $WMIAUTH = Get-WmiObject -Class Win32_ComputerSystem -Credential $Credential -ComputerName $srv | Select-Object Name
    }
    catch {
    }
    Write-host $Server ","$DNS ","$PING "," $ADCHECK "," $AUTHCHECK "," $WMIAUTH
    "$Server,$DNS,$PING,$ADCHECK,$AUTHCHECK,$WMIAUTH" | Out-File .\server-checks.csv -Append
  
}