$servers = get-content "w-server.txt"
foreach ($Server in $Servers)
{
    $Addresses = $null
    try {
        $Addresses = [System.Net.Dns]::GetHostAddresses("$Server").IPAddressToString
    }
    catch { 
        $Addresses = "Not in DNS"
    }
    foreach($Address in $addresses) {
        write-host $Server,"$Tab" $Address 
    }
}