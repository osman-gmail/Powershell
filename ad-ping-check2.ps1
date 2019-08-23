ForEach ($server in (get-content "w-server.txt")) 
{   Try {
        $ad = Get-ADComputer $server -ErrorAction Stop > $NULL
        if ($ad -eq "") {
            $result -is $false
        $PING= Test-Connection -ComputerName $server -Count 2 -Quiet
        } else {
            $result -is $true
        $PING= Test-Connection -ComputerName $server -Count 2 -Quiet
        }

#        $ping = Test-Connection -ComputerName $server -Count 2 -Quiet
        
    }
    Catch {
        "error"
    }
    [PSCustomObject]@{
        Name = $server
        Found = $Result
        Ping = $Ping
    }
}