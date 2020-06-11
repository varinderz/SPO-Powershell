Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

function getfiles{
Param($siteUrl,$username,$password,$lib)
Clear-Host
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password)
$ctx.Credentials = $credentials

$list=$ctx.Web.Lists.GetByTitle($lib);
$files=$list.RootFolder.Files

$ctx.Load($files)
 
$ctx.ExecuteQuery(); 

$files|Select Name|Format-Table -AutoSize

  }


  function copyfiles{
Param($siteUrl,$username,$password,$srclib,$dstlib)
Clear-Host
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password)
$ctx.Credentials = $credentials

$list=$ctx.Web.Lists.GetByTitle($srclib);
$files=$list.RootFolder.Files
$destlib =$ctx.Web.Lists.GetByTitle($dstlib).RootFolder

$ctx.Load($destlib)
$ctx.Load($files)
 
$ctx.ExecuteQuery(); 

$files|ForEach-Object{
 

$SourceFile =$ctx.Web.GetFileByServerRelativeUrl($_.ServerRelativeUrl)
$ctx.Load($SourceFile)
$ctx.ExecuteQuery()
$TargetFileURL = $destlib.ServerRelativeUrl+"/"+$SourceFile.Name

$SourceFile.CopyTo($TargetFileURL, $True)
 $ctx.ExecuteQuery()


}


  }


$site="https://varindersinghdev.sharepoint.com/sites/teamsite/"
$user="varinder@varindersinghdev.onmicrosoft.com"
$pwd=Read-Host -Prompt "password"  -AsSecureString 
  

getfiles $site $user $pwd "Docs"  