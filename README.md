# GenerateSignature O365
## Synopsis
Configuração de assinaturas utilizando o powershell no Microsoft Office O365.

## Motivação
Apoos a migração de quase mil usuarios tivemos dificuldades em configurar assinaturas para toda a organização no Office Outlook para Web. Existem muitos softwares pagos disponíveis, no entanto em tempos de pandemia não havia orçamento suficiente para uma tarefa tão fácil. Segue esse script gratuitamente.

## Informação
** Esteja ciente de que este script é fornecido "como está" e, portanto, pode haver problemas principamente nas configurações dos módulos. Certifique-se de entender o script e teste antes do lançamento! **


## Requisitos
* Conta com permissões de administração no Office365
* Modulo Powershell: `MSOnline`

## Como funciona
Substitua o usuario e Senha com acesso de admin


## Preparation
Ative o protocolo tls confira se o repositorio está configurado, e instale o módulo MSOnline 
* [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::tls12
* Register-PSRepository -Default
* Install-Module MSOnline

## Templates
This script ships with two template files. `signature.html` contains the HTML version and `signature.txt` the plain version of your signature. The HTML version is used while creating pure HTML emails, the plain one by creating plan text emails. Please make sure that you always edit both files!

All variables are enclosed in square brackets. A part of the signature contains static information (f.e. name of the company) and is marked by hashtags. Please edit the file accordingly.

## Usage
* Editar os arquivos de template `Signature.html` and `Signature.txt` com os dados que precisa.
* Leia o script e substitua as variaveis com o que precisa.
* Execute o script manualmente