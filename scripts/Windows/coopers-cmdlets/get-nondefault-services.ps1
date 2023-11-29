$NonDefaultServices = @() 
$Services = Get-wmiobject win32_service | where { $_.PathName -notmatch "policyhost.exe" -and $_.Name -ne "LSM" -and $_.PathName -notmatch "OSE.EXE" -and $_.PathName -notmatch "OSPPSVC.EXE" -and $_.PathName -notmatch "Microsoft Security Client" -and $_.DisplayName -notmatch "NetSetupSvc" -and $_.Caption -notmatch "Windows" -and $_.PathName -notmatch "Windows"  }

Foreach ($Service in $Services) {
    $NonDefaultServices+= [pscustomobject]@{
        DisplayName = $Service.DisplayName
        State = $Service.State
        StartMode = $Service.StartMode
        Status = $Service.Status
        ProcessID = $Service.ProcessId                
        ExePath = $Service.PathName
        Description = $Service.Description
    }
}

Write-Output "Found $($NonDefaultServices.Count) non-default services."
Write-Output $NonDefaultServices
