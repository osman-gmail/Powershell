$srv = get-content "nt-server-list.txt"
#Check ports 5985, 5986
$cred = Get-Credential
#"Server,DNS,PING,ADCHECK,Wsman,Wsman-Auth," | Out-File .\nt-server-allchecks.csv -Force
foreach ($server in $srv)
{
    $DNS = $null
    $PING = $null
    $ADCHECK = $null
    $WSCHECK = $null
    $AUTHCHECK = $null
    $WSAUTH = $null
    try {
#        $DNS = [System.Net.Dns]::GetHostAddresses("$server").IPAddressToString 
#        $PING = Test-Connection -ComputerName $server -Count 1 -Quiet
#        $ADCHECK = Get-ADComputer $server -ErrorAction Stop | Select-Object Enabled
#        $WSCHECK = Test-WSMan $server | Select-Object ProductVersion
#        $AUTHCHECK = Test-WSMan $server -Authentication Default -Credential $cred | Select-Object ProductVersion

    }
    catch {
    }
#    Write-host $Server ","$DNS ","$PING "," $ADCHECK "," $WSCHECK "," $AUTHCHECK
#    "$Server,$DNS,$PING,$ADCHECK,$WSCHECK,$AUTHCHECK" | Out-File .\nt-server-allchecks.csv -Append
 Write-Host $server, $WSAUTH  
}