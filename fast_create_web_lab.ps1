[CmdletBinding()]
param (
[Parameter(Mandatory=$True)]
[String]$Name,
[String]$location='chinaeast'
)


Write-Host "====================================================================================="
Write-Host "Tools for Fast Create New Web App Lab"
write-host " the default resource group name will be $Name + 'group' "
Write-Host " the default Service Plan name will be $Name + 'ServicePlan' "
Write-Host " the NumberWork will be 1, WorkSize='small' "
Write-Host " the default location will be 'chinaeast', you can change it by parameter 'location' "
Write-Host "====================================================================================="



#Login Azure China
$account = Login-AzureRmAccount -Environment azurechinacloud

#check if the login failed, then failed.
if ( !$account ) {
    Write-Error "Login Failed!"
}

$groupname = $Name + "labgroup"
$serviceplanname = $Name + "labserviceplan"
#create resource group
$group = New-AzureRmResourceGroup -Name $groupname -Location $location
#create service plan
$serviceplan = New-AzureRmAppServicePlan -ResourceGroupName $groupname -Name $serviceplanname -Location $location -Tier "Basic" -NumberofWorkers 1 -WorkerSize "Small"
#create web app
$webapp = New-AzureRmWebApp -ResourceGroupName $groupname -Name $Name -Location $location -AppServicePlan $serviceplanname


Write-Host "Created Web App $Name Done!"
