$srv = get-content "w-server.txt"
foreach ($Server in $Srv)
{
    $CONN = $null
    try {
        $CONN = Test-WSMan $server 2> $null
    }
    catch {
#        $CONN = "NO Connection."
    }
# foreach($IN in $CONN) {
        write-host $Server, $CONN
#    }
}