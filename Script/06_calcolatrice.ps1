$n1= Read-Host "inserire il primo numero"
$n2= Read-Host "inserire il secondo numero"
$scelta= Read-Host "1 per addizione, 2 sottrazione, 3 moltiplicazione, 4 divisione"

switch ($scelta) {
    1 {
        $totale=$n1+$n2
        Write-Host $totale
        break
    }
    2 {
        $totale=$n1-$n2
        Write-Host $totale
        break
    }
    3 {
        $totale=$n1*$n2
        Write-Host $totale
        break
    }
    4{
        if($n2 -eq 0){
            Write-Host "Invalid input"
            break
        }
        else{
            $totale=$n1/$n2
            Write-Host $totale
        }
    }
    default {
        Write-Host "Invalid input"
    }
}