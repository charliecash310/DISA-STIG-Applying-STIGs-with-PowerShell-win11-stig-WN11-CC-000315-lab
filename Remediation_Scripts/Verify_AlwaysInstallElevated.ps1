<#  Verify compliance for STIG WN11-CC-000315
    Exit code: 0 = Compliant, 1 = Non-compliant
#>
$Paths = @(
    'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer',
    'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer'
)
$Name = 'AlwaysInstallElevated'

$nonCompliant = $false
foreach ($p in $Paths) {
    $val = (Get-ItemProperty -Path $p -Name $Name -ErrorAction SilentlyContinue).$Name
    $state = if ($null -eq $val) {"<not set> (OK)"} elseif ($val -eq 0) {"0 (OK)"} elseif ($val -eq 1) {"1 (NON-COMPLIANT)"} else {"$val (Treat as OK if not 1)"}
    Write-Output ("{0}\{1} = {2}" -f $p, $Name, $state)
    if ($val -eq 1) { $nonCompliant = $true }
}

if ($nonCompliant) { exit 1 } else { exit 0 }
