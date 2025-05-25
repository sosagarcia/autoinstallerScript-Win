# Auto-elevar a administrador si no se está ejecutando como tal
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$programs = Import-Csv -Path "programs.csv"

foreach ($program in $programs) {
    $name = $program.name
    $version = $program.version
    $quiet = $program.quiet -eq "yes"

    $params = @("install", "--id", $name, "--accept-source-agreements", "--accept-package-agreements")

    if ($version -and $version -ne "latest") {
        $params += "--version"
        $params += $version
    }

    if ($quiet) {
        $params += "--silent"
    }

    Write-Host "Installing or updating $name..." -ForegroundColor Green
    try {
        winget @params
    } catch {
        Write-Warning "Failing installing $name. Trying to update it..."
        try {
            $updateParams = @("upgrade", "--id", $name, "--accept-source-agreements", "--accept-package-agreements")
            if ($quiet) { $updateParams += "--silent" }
            winget @updateParams
        } catch {
            Write-Warning "It could not instlall $name either."
        }
    }
}