#This script is for filtering the subscription-only IAM
 
 $TenantId = "" # Enter Tenant ID
 $SubscriptionId = "" # Enter Subscription ID
 
 #Connect-AzAccount

#Select-AzSubscription -tenant $TenantId

$CsvFullPath = "C:\Azure.csv"

$results = Get-AzRoleAssignment -Scope /subscriptions/{$SubscriptionId}

$Global:ResultArray = @()

foreach ($result in $results){
    
    if ($result.Scope -eq "/subscriptions/{$SubscriptionId}") {
          $obj = New-Object -TypeName PSobject
          Add-Member -InputObject $obj -MemberType NoteProperty -Name "Scope" -Value $result.Scope
          Add-Member -InputObject $obj -MemberType NoteProperty -Name "SignInName" -Value $result.SignInName
          Add-Member -InputObject $obj -MemberType NoteProperty -Name "RoleDefintionName" -Value $result.RoleDefinitionName
          $Global:ResultArray += $obj 
    }
}

$Global:ResultArray | Export-Csv -Path $CsvFullPath -NoTypeInformation -Confirm:$false -Force

