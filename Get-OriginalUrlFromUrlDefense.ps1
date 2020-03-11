function Get-OriginalUrlFromUrlDefense {
    param (
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]$Url
    ) 

    if ($Url) {
        $UrlWithDelimiter = ($Url | Select-String "__.*__" -OutVariable SearchResult).Matches.Value
        if ($UrlWithDelimiter) {
            #remove the delimiters at the beginning and end of the Url
            if ($UrlWithDelimiter.Substring(0, 2) -eq "__") {
                $UrlWithDelimiter = $UrlWithDelimiter.Substring(2)
            }
            if ($UrlWithDelimiter.Substring($UrlWithDelimiter.Length - 2) -eq "__") {
                ($UrlWithDelimiter).SubString(0, ($UrlWithDelimiter).Length - 2)
            }
        }
        else {
            Write-Error "Url value does not contain the proper double-underscore delimiters"
        }
    }
} #end Get-sjUrlFromUrlDefense function

# examples:
# Get-OriginalUrlFromUrlDefense
# Get-OriginalUrlFromUrlDefense -Url "https://urldefense.com/v3/__https://info.databricks.com/dc/iqoSFi8gRxN3bjGZEDn90EjHxqOFCR2NzPdiA0JFHdX0IdwPlwSu4ZUIkP-L8dy-S3IhJ8vFXu5rT4cyemtY8kUaEFQuX2p5XNG0zsfYbUPW2oy8syn06YHS3nsbeGmc/CMS00V0Kh0PY0CoP0U0rS0r__"
# Get-OriginalUrlFromUrlDefense -Url ""
# Get-OriginalUrlFromUrlDefense "blah"
