param (
    [Parameter(Position = 0)]
    [ValidateNotNullOrEmpty()]
    [string]$Url #= "https://urldefense.com/v3/__https://info.databricks.com/dc/iqoSFi8gRxN3bjGZEDn90EjHxqOFCR2NzPdiA0JFHdX0IdwPlwSu4ZUIkP-L8dy-S3IhJ8vFXu5rT4cyemtY8kUaEFQuX2p5XNG0zsfYbUPW2oy8syn06YHS3nsbeGmc/CMS00V0Kh0PY0CoP0U0rS0r__"
) 

if ($Url) {
    $UrlWithDelimiter = ($Url | Select-String "__.*__" -OutVariable SearchResult).Matches.Value
    #remove the delimiters at the beginning and end of the Url
    if ($UrlWithDelimiter.Substring(0, 2) -eq "__") {
        $UrlWithDelimiter = $UrlWithDelimiter.Substring(2)
    }
    if ($UrlWithDelimiter.Substring($UrlWithDelimiter.Length - 2) -eq "__") {
        ($UrlWithDelimiter).SubString(0, ($UrlWithDelimiter).Length - 2)
    }
}

# examples:
# .\ReturnUrlFromUrlDefense.ps1 -Url "https://urldefense.com/v3/__https://info.databricks.com/dc/iqoSFi8gRxN3bjGZEDn90EjHxqOFCR2NzPdiA0JFHdX0IdwPlwSu4ZUIkP-L8dy-S3IhJ8vFXu5rT4cyemtY8kUaEFQuX2p5XNG0zsfYbUPW2oy8syn06YHS3nsbeGmc/CMS00V0Kh0PY0CoP0U0rS0r__"
# .\ReturnUrlFromUrlDefense.ps1 -Url ""
# .\ReturnUrlFromUrlDefense.ps1
