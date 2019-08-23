$srv = get-content "list.txt"
$cred = Get-Credential

foreach ($server in $srv)
{
    $result = $null
    $session = New-pssession -credential $cred -computername $server
    $result = Invoke-command -session $session -scriptblock {
        #Return Get-LocalGroupMember -Group "Administrators" 
        return $(net localgroup administrators)
    }
   Write-Output $server $result

   if($result){
    if ($server.Substring(0,1) -eq "w") {
        $display = $result -match "AGG-WindowsServer-All-Administrators"
    } elseif ($server.Substring(0,2) -eq "nt") {
        $display = $result -match "Server Admins"
    }
   }else{
    $display = $null
   }

   $server + "================================================" ,$display | Out-File .\servers-local-admin.txt -Append
}  