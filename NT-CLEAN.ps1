$servers = get-content "nt-server-list.txt"
foreach ($server in $servers) {
#Get-ADComputer -Identity $server -Properties IPv4Address | FT Name,DNSHostName,IPv4address
if (Get-ADComputer $server -eq $null) { 
Write-Host "$server not there"
} 
    else {
    Write-Host "$Server Found In AD!"
    }
}