$voto= Read-Host "inserisci il voto"
if([int]$voto -ge 6){
    Write-Output "promosso"
}
else{
    Write-Output "bocciato"
}