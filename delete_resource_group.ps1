Write-Host "==============================================="
Write-Host "Tools for Delete Resource Group"
Write-Host "==============================================="


#Login Azure China
$account = Login-AzureRmAccount -Environment azurechinacloud

#check if the login failed, then failed.
if ( !$account ) {
    Write-Error "Login Failed!"
}

$subscripts = Get-AzureRmSubscription
Write-Host "Current you got those subscriptions"
Write-Host "==============================================="
$subscripts

Write-Host "==============================================="

$subscriptionId = Read-Host "Please input which subscripts id as your default context"
$context = Set-AzureRmContext $subscriptionId

$groups = Get-AzureRmResourceGroup  |Select-Object -Property ResourceGroupName, Location

Write-Host "Current there are those ResourceGroups"
$groups

$deleteGroup = Read-Host "please input which group you will delete,a/A will be delete all of them"
if ( $deleteGroup -eq "a" -or $deleteGroup -eq "A") {
    $groups | Remove-AzureRmResourceGroup -Force
} else {
    Remove-AzureRmResourceGroup $deleteGroup -Force
}

Write-Host "Done!"


