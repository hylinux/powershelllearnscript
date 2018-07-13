
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