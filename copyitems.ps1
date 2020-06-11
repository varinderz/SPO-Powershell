[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")
function copyitems{
Param($siteUrl,$username,$password)
#$siteUrl = "https://varindersinghdev.sharepoint.com/sites/teamsite/"
#$username = "varinder@varindersinghdev.onmicrosoft.com"
#$password =   Read-Host  -Prompt "Enter password" -AsSecureString 
$password = ConvertTo-SecureString $password -AsPlainText -Force
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)
$srclistname= Read-Host -Prompt "Enter Source List Name"
$destlistname= Read-Host -Prompt "Enter Destination List Name"

$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password)
$ctx.Credentials = $credentials
$srclist= $ctx.Web.Lists.GetByTitle($srclistname);
$destlist= $ctx.Web.Lists.GetByTitle($destlistname);
$camlqry=New-Object Microsoft.SharePoint.Client.CamlQuery
$srcitems=$srclist.GetItems([Microsoft.SharePoint.Client.CamlQuery]::CreateAllItemsQuery())

$ctx.Load($srcitems);
$ctx.ExecuteQuery() 

$srcitems|ForEach-Object{

#Write-Host $_["Title"]

$iteminfo= New-Object Microsoft.SharePoint.Client.ListItemCreationInformation
$newitem=$destlist.AddItem($iteminfo);
$newitem["Title"]= $_["Title"] 
$newitem.Update();

Write-Host $_["Title"] "Item Created successfully" -f "yellow"

}

$destitems=$destlist.GetItems([Microsoft.SharePoint.Client.CamlQuery]::CreateAllItemsQuery())

$ctx.Load($destitems);
$ctx.ExecuteQuery() 

$destitems|ForEach-Object{

Write-Host $_["Title"]
}
}

copyitems  "https://varindersinghdev.sharepoint.com/sites/teamsite/" "varinder@varindersinghdev.onmicrosoft.com" "password"