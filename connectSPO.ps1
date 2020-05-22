[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")

$siteUrl = Read-Host  -Prompt "Enter site url"
$username = Read-Host  -Prompt "Enter user name"
$password =   Read-Host  -Prompt "Enter password" -AsSecureString 
 
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)


$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password)
$ctx.Credentials = $credentials

$rootWeb = $ctx.Web
$lists=$rootWeb.Lists;
$ctx.Load($rootWeb);
$ctx.Load($lists)
$ctx.ExecuteQuery()

Write-Host "web site Title is " $rootWeb.Title
Write-Host "Count of lists is " $lists.count
