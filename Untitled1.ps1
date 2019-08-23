ForEach ($server in (get-content "w-server.txt"))
{   Try {
        Get-ADComputer $server -ErrorAction Stop > $null
        $Result = $true
    }
    Catch {
        $Result = $False
    }
    [PSCustomObject]@{
        Name = $server
        Found = $Result
    }
}