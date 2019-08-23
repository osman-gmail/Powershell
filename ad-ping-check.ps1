#Goal
#Ping, AD, Auth, DNS, Asset (Remedy/Roogle)

$res = $null


$cred = (Get-Credential)

$servers = (get-content "w-server.txt")

$servers = $servers | select -first 2


$res = $null


ForEach ($server in $servers) {
    $ad = Get-ADComputer $server -ErrorAction ignore
    if ($ad) {
        $result - $true
    } else {
        $result - $false
    }


    Test-WSMan -ComputerName $server -Authentication Default -Credential $cred

    $ping = Test-Connection -ComputerName $server -Count 2 -Quiet

    $res | Add-Member -MemberType NoteProperty -Name name -Value $server
    $res | Add-Member -MemberType NoteProperty -Name found -value $result
    $res | Add-Member -MemberType NoteProperty -Name ping -value $ping

    $res += @{
        "name" = $server
        "found" = $result
        "ping" = $ping
    }

 
}

