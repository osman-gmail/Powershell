$srv = get-content "w-server.txt"
foreach ($Server in $Srv)
{
    $PING = $null
    try {
        $PING = Test-Connection -ComputerName $server -Count 2 -Quiet
    }
    catch {
    }
    Write-Host $Server, $PING

}