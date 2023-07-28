$string1= "prova"
$string2= "secondo"
$string3= "$string1 $string2"
Write-Host $string3



$string5="provaaaaaaa"
$substring=$string5.Substring(2,3)
Write-Host $substring



$replace= $string5.Replace("aa","oo")
Write-Host $replace



if($string5.Contains("aa")){
    Write-Host yes
}else{
    Write-Host no bro
}

$email="a@a.it"
if($email.IndexOf("@") -eq 1){
    Write-Host "contiene @"
}else{
    Write-Host non contiene
}



$pswd="1234"
$pswdControllo="1234"
if($pswd -eq $pswdControllo){
    Write-Host coincidono
}else{
    Write-Host non coincidono
}



$date= Get-Date
Write-Host $date
Write-Host $date.ToString("dd/mm/yyyy")



$array=@("padova" , "vicenza", "treviso", "venezia")
Write-Host $array
Write-Host $array.Count
foreach($city in $array){
    Write-Host $city
}
