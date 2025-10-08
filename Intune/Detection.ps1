# Detection script for Intune Proactive Remediations
# Returns exit code 1 if remediation is needed (non-compliant), 0 if compliant

$paths = @(
  'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer',
  'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer'
)
$name = 'AlwaysInstallElevated'

$needsFix = $false
foreach ($p in $paths) {
  $val = (Get-ItemProperty -Path $p -Name $name -ErrorAction SilentlyContinue).$name
  if ($val -eq 1) { $needsFix = $true }
}

if ($needsFix) { exit 1 } else { exit 0 }
