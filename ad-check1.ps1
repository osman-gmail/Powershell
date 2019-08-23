$servers = get-content "test.txt"
    foreach ($Server in $Servers)
    {
    Get-ADComputer $server -Properties *
    }