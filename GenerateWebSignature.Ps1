<# 
.SYNOPSIS Configurar Assinatura online do Microsoft Office 365
.DESCRIPTION
.NOTES Use por sua conta e risco!
.COMPONENT Requires Module MSOnline
#>

##### FUNCAO INSTALL MODULES #####
function o365_install {
	#Verificar versão do Power Shell
	#Get-Host | Select-Object Version
	#Configurar Protocolo TLS
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::tls12

	#Registrar Repositorio Padrão
	Register-PSRepository -Default

	#Instalar modulo de conexão com Office 365
	Install-Module MSOnline
}


##### FUNCAO CONECTAR #####
function o365_connect {
	try{
	    $Username = "usuario@dominio.com.br"
		$Password = ConvertTo-SecureString 'Senha' -AsPlainText -Force
		$LiveCred = New-Object System.Management.Automation.PSCredential $Username, $Password
		Connect-MsolService -Credential $LiveCred
		$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $LiveCred -Authentication Basic -AllowRedirection
		Import-PSSession $Session
		Connect-MsolService -Credential $LiveCred
	}
	catch
	{
	    Write-Host Erro ao conectar, verifique suas credenciais.
	    Exit
	}

}

##### CONECTAR #####
o365_connect

##### VARIAVEIS,  SUBSTITUIA COM SEU BANCO DE DADOS #####
$DisplayName = "Erich Carlos de Oliveira"
$JobTitle = "Gerente de Projetos"
$TelephoneNo = "(33) 3339-3837"
$MobileNo = "(32) 98421-5893"
$EmailAddress = "erich.oliveira@engelmig.com.br";
$Department  = "Tecnologia da Informação"

##### TEMPLATE HTML #####
$FileHtml = "Signature.html"
$SignatureHTML = Get-Content -Path $FileHtml -encoding utf8 -ReadCount 0

if (Test-Path -Path $SignatureHTML) {

	$SignatureHTML = $SignatureHTML.Replace("[DisplayName]", $DisplayName)
	$SignatureHTML = $SignatureHTML.Replace("[JobTitle]", $JobTitle)
	$SignatureHTML = $SignatureHTML.Replace("[TelephoneNo]", $TelephoneNo)
	$SignatureHTML = $SignatureHTML.Replace("[EmailAddress]", $EmailAddress)
	if ($MobileNo -like "") {
	    $SignatureHTML = $SignatureHTML.Replace("[MobileNo]", "")
	 }
	 else {
	   $SignatureHTML = $SignatureHTML.Replace("[MobileNo]", $MobileNo)
	}

}

##### TEMPLATE TXT #####
$FileTxt = "Signature.txt"
$SignaturePlain = Get-Content -Path $FileTxt -encoding utf8 -ReadCount 0
if (Test-Path -Path $SignaturePlain) {
	$SignaturePlain = $SignaturePlain.Replace("[DisplayName]", $DisplayName)
	$SignaturePlain = $SignaturePlain.Replace("[JobTitle]", $JobTitle)
	$SignaturePlain = $SignaturePlain.Replace("[TelephoneNo]", $TelephoneNo)
	$SignaturePlain = $SignaturePlain.Replace("[EmailAddress]", $EmailAddress)
	if ($MobileNo -like "") {
	    $SignaturePlain = $SignaturePlain.Replace("[MobileNo]", "")
	 }
	 else {
	   $SignaturePlain = $SignaturePlain.Replace("[MobileNo]", $MobileNo)
	}
}



##### CONFIGURAR ASSINATURA #####
Set-MailboxMessageConfiguration -Identity $EmailAddress -AutoAddSignature $True -AutoAddSignatureOnReply $False -SignatureText $SignaturePlain -SignatureHTML $SignatureHTML
Write-Host Assinatura adicionada para for $EmailAddress -ForegroundColor Green

##### DESCONECTAR #####
get-PSSession | remove-PSSession