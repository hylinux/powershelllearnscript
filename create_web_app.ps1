Write-Host "==============================================="
Write-Host "Tools for Create New Web App Lab"
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

Write-Host "We try to get all location for Azure China......"
$locations = Get-AzureRmLocation | Select-Object -Property Location
Write-Host "Done! so far, we have those locations:"
Write-Host "==============================================="
$locations | ForEach-Object -Process { $_ }
Write-Host "==============================================="

$location = Read-Host "Please choose which location which you will create resource(input location name)"
$groupname = Read-Host "please input your Resource Group Name"

$group = $null

while ( $true ) {
    $group = New-AzureRmResourceGroup -Name $groupname -Location $location

    if ( $group ) {
        break
     } else {
        $groupname = Read-Host "please input your Resource Group Name again"
     }
}

Write-Host "Resource group $groupname was created Success!"

#choose will be create a new serviceplan or choose a exists service plan
Write-Host "Because this Script purpose is for Lab,  then we will use `Basic` Tier, and 2 NumberWorks, `Small` for WorkSize"
$planname = Read-Host "please input Service Plan Name"
$serviceplan = New-AzureRmAppServicePlan -ResourceGroupName $groupname -Name $planname -Location $location -Tier "Basic" -NumberofWorkers 2 -WorkerSize "Small"

if ( !$serviceplan ) {
    Write-Error "create service plan $planname failed!"
}

$webappname = Read-Host "Please input the Web App Name"

while ( $true ) {
    $web = New-AzureRmWebApp -ResourceGroupName $groupname -Name $webappname -Location $location -AppServicePlan $planname
    
    if ( $web ) {
        break
    } else {

        $webappname = Read-Host "the Web App create failed!, please input the webapp name again"
    }

}


Write-Host "$webappname created success!"




