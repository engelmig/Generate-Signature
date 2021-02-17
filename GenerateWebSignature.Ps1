<# 
.SYNOPSIS Configurar Assinatura online do Microsoft Office 365
.DESCRIPTION
.NOTES	Use por sua conta e risco!
  Version:        1.0
  Author:         Erich Oliveira https://www.linkedin.com/in/oliveiraerich/
  Modified:       15/02/2021
.COMPONENT Requires Module MSOnline
#>

##### FUNCAO INSTALL MODULES #####
function o365_install {
	#Verificar versão do Power Shell
	Get-Host | Select-Object Version
	#Configurar Protocolo TLS
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::tls12

	#Registrar Repositorio Padrão
	Get-PSRepository
	Register-PSRepository -Default

	#Instalar modulo de conexão com Office 365
	Install-Module MSOnline
}


##### FUNCAO CONECTAR #####
function o365_connect {
	try{
		#Armazena na variável $LiveCred os dados de acesso fornecidos por Linha de Comando
	     
	    #$Username = "usuario@dominio.com.br"
		#$Password = ConvertTo-SecureString 'Senha' -AsPlainText -Force
		#$LiveCred = New-Object System.Management.Automation.PSCredential $Username, $Password
		
		#Armazena na variável $cred os dados de acesso fornecidos pelo usuário mediante ao PopUp exibido
		$LiveCred = get-credential -message "Digite o email com permissoes de administrador do Office 365"

		#Estabelece conexão com o Office365
		Connect-MsolService -Credential $LiveCred

		#Conecta com o tenant do Office365
		$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $LiveCred -Authentication Basic -AllowRedirection
		Import-PSSession $Session

	}
	catch
	{
	    Write-Host Erro ao conectar, verifique suas credenciais.
	    Exit
	}

}

##### CONECTAR #####
o365_connect

##### VARIAVEIS,  SUBSTITUA COM OS DADOS DO BANCO DE DADOS #####
$DisplayName = "Erich Carlos de Oliveira"
$JobTitle = "Gerente de Projetos"
$TelephoneNo = "(33) 3339-3837"
$MobileNo = "(32) 98421-5893"
$EmailAddress = "erich.oliveira@engelmig.com.br";
$Department  = "Tecnologia da Informação"

##### TEMPLATE HTML #####
#Importa o arquivo HTML da assinatura com os padrões predefinidos
$FileHtml = "Signature.html"
$SignatureHTML = Get-Content -Path $FileHtml -ReadCount 0

if (Test-Path -Path $SignatureHTML) {

	#Substitui as variaveis do arquivo html com os valores configurados
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
#Registra nova assinatura na caixa de e-mail do Outlook 365
Set-MailboxMessageConfiguration -Identity $EmailAddress -AutoAddSignature $True -AutoAddSignatureOnReply $False -SignatureText $SignaturePlain -SignatureHTML $SignatureHTML

Write-Host Assinatura adicionada para $EmailAddress -ForegroundColor Green

<#
$list = Get-MsolUser -DomainName 'engelmig.com.br' -All 
 foreach($user in $list) {
        $userPrincipalName     = $user.UserPrincipalName       #Armazena na variável $userPricipalName o e-mail do usuário
        $fullName              = $user.DisplayName             #Armazena na variável $displayName o nome completo do usuário
        $depart                = $user.Department              #Armazena na variável $depart o departamento que o usuário trabalha
        $phone                 = $user.PhoneNumber             #Armazena na variável $phone o telefone corporativo do usuário

	echo "A assinatura de e-mail do usuário $userPrincipalName foi atribuída ao Outlook."
}
#>

##### DESCONECTAR #####
get-PSSession | remove-PSSession