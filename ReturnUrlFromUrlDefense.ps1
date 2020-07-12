param (
    [Parameter(Position = 0)]
    [ValidateNotNullOrEmpty()]
    [string]$Url #= "https://urldefense.com/v3/__https://github.com/steven__judd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"
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
# .\ReturnUrlFromUrlDefense.ps1 -Url "https://urldefense.com/v3/__https://github.com/stevenjudd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"
# .\ReturnUrlFromUrlDefense.ps1 -Url ""
# .\ReturnUrlFromUrlDefense.ps1
# wut? ^^^
