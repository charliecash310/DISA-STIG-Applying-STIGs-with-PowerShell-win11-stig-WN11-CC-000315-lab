# DISA-STIG-Applying-STIGs-with-PowerShell-win11-stig-WN11-CC-000315-lab
# 🛡️ Windows 11 STIG Remediation: Disable “Always install with elevated privileges”

**STIG ID:** WN11-CC-000315  
**Severity:** High  
**CCI:** CCI-001812  
**Vulnerability ID:** V-253411  
**Updated:** 2025-10-06 03:36:51Z

---

## 📖 Vulnerability Summary

The Windows Installer feature **"Always install with elevated privileges"** must be disabled.  
If enabled, it allows Windows Installer to use elevated privileges for all MSI installs—even for standard users—creating a path to full system compromise.

---

## 🔍 Check Procedure

Verify the following registry values:

| Hive | Path | Value Name | Type | Expected Value |
|------|------|-------------|------|----------------|
| `HKEY_LOCAL_MACHINE` | `\SOFTWARE\Policies\Microsoft\Windows\Installer` | `AlwaysInstallElevated` | `REG_DWORD` | `0` (or not present) |
| `HKEY_CURRENT_USER`  | `\SOFTWARE\Policies\Microsoft\Windows\Installer` | `AlwaysInstallElevated` | `REG_DWORD` | `0` (or not present) |

If either value is set to `1`, this is a **finding**.

---

## 🧰 Fix Procedures

### Option 1 — Local Group Policy (GUI)

1. `Win + R` → `gpedit.msc`
2. Navigate:  
   `Computer Configuration → Administrative Templates → Windows Components → Windows Installer`
3. Open **Always install with elevated privileges** → set to **Disabled** → **OK**.
4. Repeat under:  
   `User Configuration → Administrative Templates → Windows Components → Windows Installer`
5. Run `gpupdate /force` and verify with `gpresult /h C:\gp.html`.

### Option 2 — Registry (Manual)

Set the following DWORDs to `0` (create if missing):
- `HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated`
- `HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated`

### Option 3 — Scripts / Files in This Repo

- `Disable_AlwaysInstallElevated.ps1` → Remediates HKLM/HKCU and verifies
- `Verify_AlwaysInstallElevated.ps1` → Returns exit code 0 (compliant) or 1 (non‑compliant)
- `Disable_AlwaysInstallElevated.reg` → Double‑click to apply via Registry
- `Intune/Detection.ps1` + `Intune/Remediation.ps1` → For Proactive Remediations

---

## ✅ Verification

- Both HKLM/HKCU are `0` **or not present**  
- Re-run your scanner (STIG Viewer/SCC/Tenable) → Should report **Compliant**

---

## 📂 Repository Layout

```
STIG_WN11-CC-000315_DisableAlwaysInstallElevated/
├── README.md
├── Disable_AlwaysInstallElevated.reg
├── Remediation_Scripts/
│   ├── Disable_AlwaysInstallElevated.ps1
│   └── Verify_AlwaysInstallElevated.ps1
└── Intune/
    ├── Detection.ps1
    └── Remediation.ps1
```

---

## 🧠 References

- DISA STIG Viewer — STIG: **WN11-CC-000315**
- Microsoft Docs: Windows Installer policies → *AlwaysInstallElevated*

**Author:** Grisham D. (Forward_Advice) · *Cybersecurity // Help Desk Projects*  
**License:** MIT
