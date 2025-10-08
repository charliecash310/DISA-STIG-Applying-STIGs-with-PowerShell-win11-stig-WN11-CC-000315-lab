# Remediation script for Intune Proactive Remediations
$paths = @(
  'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer',
  'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer'
)
$name = 'AlwaysInstallElevated'

foreach ($p in $paths) {
  New-Item -Path $p -Force | Out-Null
  New-ItemProperty -Path $p -Name $name -Value 0 -PropertyType DWord -Force | Out-Null
}
