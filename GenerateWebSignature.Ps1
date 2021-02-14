# Funcao conectar no office 365
function o365_connect {
    $Username = "email@dominio.com"
	$Password = ConvertTo-SecureString 'SuaSenha' -AsPlainText -Force
	$LiveCred = New-Object System.Management.Automation.PSCredential $Username, $Password
	Connect-MsolService -Credential $LiveCred
	$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $LiveCred -Authentication Basic -AllowRedirection
	Import-PSSession $Session
	Connect-MsolService -Credential $LiveCred
}

o365_connect


Set-MailboxMessageConfiguration -Identity erich.oliveira -AutoAddSignature $True -AutoAddSignatureOnReply $False -SignatureText 'Erich Oliveira' -SignatureHTML "<div style='float: left; margin-right: 12px;' data-v-67a79838=''><img style='border-radius: 50%; border: 2px solid #ffca2b; padding: 2px; display: block; margin-left: auto; margin-right: auto;' src='https://cdn.engelmig.com/perfil/erich.oliveira@engelmig.com.br.jpg' width='100' height='100' data-v-67a79838='' /></div><div style='display: inline-block;' data-v-67a79838=''><strong style='font-size: 14px; font-family: Arial, Helvetica, sans-serif; color: #000000; font-weight: bold;' data-v-67a79838=''>Erich Carlos de Oliveira</strong> <strong style='font-size: 10px; font-family: Arial, Helvetica, sans-serif; color: #767474; display: block; padding-bottom: 8px; font-weight: bold;'>Gerente de Projetos<br/>Tecnologia da Informação</strong> <span style='font-size: 10px; font-family: Arial, Helvetica, sans-serif; color: #767474; display: block; text-decoration: none;' data-v-67a79838=''>33 3339 3837 | 32 984215893</span> <a style='font-size: 10px; font-family: Arial, Helvetica, sans-serif; color: #767474; display: block; text-decoration: none;' href='www.engelmig.com.br' target='_blank' rel='noopener'>www.engelmig.com.br</a><div data-v-67a79838=''><a style='padding: 5px 8px 14px 0px; display: inline-block;' href='https://www.linkedin.com/company/engelmig-energia/' target='_blank' rel='noopener'><img src='https://i.imgur.com/9Yqo76F.png' /></a> <a style='padding: 5px 8px 14px 0px; display: inline-block;' href='https://www.instagram.com/engelmigenergia/' target='_blank' rel='noopener'><img src='https://i.imgur.com/TD70zPi.png' /></a> <a style='padding: 5px 8px 14px 0px; display: inline-block;' href='https://twitter.com/EngelmigEnergia' target='_blank' rel='noopener'><img src='https://i.imgur.com/vABUPjb.png' /></a> <a style='padding: 5px 8px 14px 0px; display: inline-block;' href='https://www.youtube.com/channel/UCgNmK1iMynXbq7KM1-szK7w' target='_blank' rel='noopener'><img src='https://i.imgur.com/JrdnaYp.png' /></a></div></div>"
