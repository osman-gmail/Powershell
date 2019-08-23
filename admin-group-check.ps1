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
   $server, "=================================================", $result | Out-File .\servers-local-admin.txt -Append
}  