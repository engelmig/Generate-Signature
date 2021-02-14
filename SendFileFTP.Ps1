$File = "C:\Users\erich.oliveira.jpg";
$ftp = "ftp://usuario:senha@dominio.com/caminho/profile/usuario1.jpg";

Write-Host -Object "ftp url: $ftp";
$webclient = New-Object -TypeName System.Net.WebClient;
$uri = New-Object -TypeName System.Uri -ArgumentList $ftp;
Write-Host -Object "Enviando $File...";

$webclient.UploadFile($uri, $File);