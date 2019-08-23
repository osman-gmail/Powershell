$servers = get-content "server-list1.txt"
foreach ($Server in $Servers)
{
    $Addresses = $null
    try {
        $Addresses = [System.Net.Dns]::GetHostAddresses("$Server").IPAddressToString
    }
    catch { 
        $Addresses = "Server IP cannot be resolved."
    }
    foreach($Address in $addresses) {
        Write-Host $Server, $Address 
    }
}