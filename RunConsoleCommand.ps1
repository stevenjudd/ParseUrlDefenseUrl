$content = Get-Content .\ConsoleCommand.ps1
Clear-Host
foreach ($line in $content) {
    Write-Host "$line"
    Write-Host ''
    if ($line -match "^#") {
        Start-Sleep -Seconds 2
    }
    elseif ($line) {
        Invoke-Expression -Command $line
        Write-Host ' '
        Wait-Debugger
        Clear-Host
    }
}