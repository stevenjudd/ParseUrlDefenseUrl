$content = Get-Content .\ConsoleCommand.ps1
if (-not ($global:PSReadLineOptionPredictionSource)) {
  $global:PSReadLineOptionPredictionSource = (Get-PSReadLineOption).PredictionSource
}
Set-PSReadLineOption -PredictionSource None
Clear-Host #please only use this cmdlet for demonstrations
foreach ($line in $content) {
  if ($line -match '^#') {
    Write-Host "$line" -ForegroundColor Green
    Write-Host ''
    Start-Sleep -Seconds 2
  } elseif ($line) {
    Write-Host "PS> $line"
    Write-Host ''
    Invoke-Expression -Command $line | Out-Host
    Write-Host ('=' * $Host.UI.RawUI.WindowSize.Width)
    Write-Host ' '
    Wait-Debugger
    # $null = Read-Host 'Press Enter to continue'
    Clear-Host
  }
}
Set-PSReadLineOption -PredictionSource $PSReadLineOptionPredictionSource
