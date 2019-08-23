$srv = get-content "list.txt"
$cred = Get-Credential
foreach ($server in $srv)
{
    $WMIAUTH = $null
    try {
        $WMIAUTH = Get-WmiObject -Class Win32_ComputerSystem -Credential $cred -ComputerName $server | Select-Object Name
    }
    catch {
    }
    Write-host $server "," $WMIAUTH
}