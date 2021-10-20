#Connect-AzAccount

#Select-AzSubscription -tenant "97f55d35-1929-4acf-9c11-d7aaf05b6756"

$CsvFullPath = "C:\Azure.csv"

$results = Get-AzRoleAssignment -Scope /subscriptions/1e984346-edba-4a2c-8888-cf0f668bea68

$Global:ResultArray = @()

foreach ($result in $results){
    
    if ($result.Scope -eq "/subscriptions/1e984346-edba-4a2c-8888-cf0f668bea68") {
          $obj = New-Object -TypeName PSobject
          Add-Member -InputObject $obj -MemberType NoteProperty -Name "Scope" -Value $result.Scope
          Add-Member -InputObject $obj -MemberType NoteProperty -Name "SignInName" -Value $result.SignInName
          Add-Member -InputObject $obj -MemberType NoteProperty -Name "RoleDefintionName" -Value $result.RoleDefinitionName
          $Global:ResultArray += $obj 
    }
}

$Global:ResultArray | Export-Csv -Path $CsvFullPath -NoTypeInformation -Confirm:$false -Force

