foreach ($server in $srv)
{
    $DNS = $null
    $PING = $null
    $ADCHECK = $null
    $WSCHECK = $null
    try {
        $DNS = [System.Net.Dns]::GetHostAddresses("$server").IPAddressToString 
        $PING = Test-Connection -ComputerName $server -Count 1 -Quiet
        $ADCHECK = Get-ADComputer $server -ErrorAction Stop | Select-Object Enabled
        $WSCHECK = Test-WSMan $server 2> $null
    }
    catch {
    }
    Write-host $Server ","$DNS ","$PING "," $ADCHECK "," $WSCHECK "," 
    "$Server , $DNS , $PING , $ADCHECK , $WSCHECK " | Out-File .\first.csv -Append
  
}