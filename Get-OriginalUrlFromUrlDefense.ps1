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
# Get-OriginalUrlFromUrlDefense -Url "https://urldefense.com/v3/__https://github.com/steven__judd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"
# Get-OriginalUrlFromUrlDefense -Url ""
# Get-OriginalUrlFromUrlDefense
# Get-OriginalUrlFromUrlDefense "blah"
