function MostraMenu {
    Clear-Host
    Write-Host "premi 1 per opzione 1"
    Write-Host "premi 2 per opzione 2"
    Write-Host "premi 3 per opzione 3"
    Write-Host "premi Q per uscire"
}
do {
    MostraMenu
    $scelta= Read-Host "fai scelta: "
    switch ($scelta) {
        "1" { 
            Write-Host "premi 1 per opzione 1"
         }
         "2" { 
            Write-Host "premi 2 per opzione 2"
         }
         "3" { 
            Write-Host " premi 3 per opzione 3"
         }
    }
    pause
} until ( 
    <# Condition that stops the loop if it returns true #>
    $scelta -eq "Q"
)