# =========================
# PARAMETERS
# =========================

$FirefoxPolicies = @{
    WindowsSSO              = $true
    DisableTelemetry        = $true
    DisableFirefoxAccounts  = $true
    DisablePocket           = $true
    DisableAppUpdate        = $true
    BackgroundAppUpdate     = $false
    Homepage                = @{
        URL    = "https://intranet.bedrijf.nl"
        Locked = $true
    }
    DisplayBookmarksToolbar = $true
}

$FirefoxInstallPath = "C:\Program Files\Mozilla Firefox"
$DistributionPath  = Join-Path $FirefoxInstallPath "distribution"
$PoliciesFilePath  = Join-Path $DistributionPath "policies.json"

# =========================
# VALIDATION
# =========================

if (-not (Test-Path $FirefoxInstallPath)) {
    Write-Error "Firefox installatiepad niet gevonden: $FirefoxInstallPath"
    exit 1
}

if (-not (Test-Path $DistributionPath)) {
    New-Item -Path $DistributionPath -ItemType Directory -Force | Out-Null
}

# =========================
# JSON
# =========================

$PoliciesObject = @{
    policies = $FirefoxPolicies
}

$JsonContent = $PoliciesObject | ConvertTo-Json -Depth 10

Set-Content `
    -Path $PoliciesFilePath `
    -Value $JsonContent `
    -Encoding UTF8 `
    -Force
