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
    Write-Host "yes"
}else{
    Write-Host "no bro"
}