#this script is intended to run after copying the URL to the clipboard from a defended email
#the next line is for testing
#Set-Clipboard -Value "https://urldefense.com/v3/__https://info.databricks.com/dc/iqoSFi8gRxN3bjGZEDn90EjHxqOFCR2NzPdiA0JFHdX0IdwPlwSu4ZUIkP-L8dy-S3IhJ8vFXu5rT4cyemtY8kUaEFQuX2p5XNG0zsfYbUPW2oy8syn06YHS3nsbeGmc/CMS00V0Kh0PY0CoP0U0rS0r__"

#get URL from clipboard
$url = Get-Clipboard
if (-not($url)) {
    Write-Error "Nothing in the clipboard. Please copy the URL Defense string to parse into the clipboard before running the script."
    return
}
($url | Select-String "__.*__" -OutVariable SearchResult | Select-Object -ExpandProperty "Matches").Value.SubString(2, ($SearchResult | Select-Object -ExpandProperty Matches).Length - 4)
