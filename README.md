# GenerateSignature O365
## Synopsis
Configuração de assinaturas utilizando o powershell no Microsoft Office O365.

## Motivação
Após a migração de quase mil usuarios para plataforma do Microsoft Office 365, Havia a demanda de padronizar as assinaturas dos usários. Existem muitos softwares pagos disponíveis, no entanto em tempos de pandemia não havia orçamentos suficiente para uma tarefa tão fácil. Portanto se está com esse mesmo desafio, Segue esse script gratuitamente.

## Informação
** Esteja ciente de que este script é fornecido "como está" e, portanto, pode haver problemas principamente nas configurações dos módulos. Certifique-se de entender o script e teste antes do lançamento! **


## Requisitos
* Conta com permissões de administração no Office365
* Modulo Powershell: `MSOnline`

## Como funciona
Substitua o usuario e Senha com acesso de administrador


## Preparação
Ative o protocolo tls confira se o repositorio está configurado, e instale o módulo MSOnline 
* [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::tls12
* Register-PSRepository -Default
* Install-Module MSOnline

## Templates
Este script vem com dois arquivos de modelo. `Signature.html` contém a versão HTML e` Signature.txt` a versão simples de sua assinatura. A versão HTML é usada ao criar emails em HTML puro, e a versão texto ao criar emails de texto de plano. Certifique-se de sempre editar ambos os arquivos!

Todas as variáveis ​​estão entre colchetes. Uma parte da assinatura contém informações estáticas (por exemplo, nome da empresa) e é marcada por hashtags. Edite o arquivo de acordo.

## Como usar
* Editar os arquivos de template `Signature.html` and `Signature.txt` com os dados que precisa.
* Leia o script e substitua as variaveis com o que precisa.
* Execute o script manualmente