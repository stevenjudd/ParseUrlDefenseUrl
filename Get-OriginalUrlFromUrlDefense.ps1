function Get-OriginalUrlFromUrlDefense {
    <#
    .SYNOPSIS
        Extract the imbedded URL from a URL Defense link
    .DESCRIPTION
        This function will return the imbedded URL that is inside a URL from a URL 
        Defense link. This makes it easier to read the destination link and also to 
        potentially load and test the URL if desired.
    .EXAMPLE
        Get-OriginalUrlFromUrlDefense -Url "https://urldefense.com/v3/__https://github.com/stevenjudd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"
        This command will return the imbedded URL from the specified value for the Url parameter.
    .EXAMPLE
        $Url = "https://urldefense.com/v3/__https://github.com/stevenjudd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"
        $Url | Get-OriginalUrlFromUrlDefense
        This command is setting the URL value to the $Url variable. This variable is 
        passed via the pipeline to the function and will return the imbedded URL.
    .EXAMPLE
        Get-OriginalUrlFromUrlDefense -Url ""
        This command will return an error since the Url parameter value is empty.
    .EXAMPLE
        Get-OriginalUrlFromUrlDefense "blah"
        This command will return an error since the Url parameter value does not conform
        to the urldefense format.
    .EXAMPLE
        Get-OriginalUrlFromUrlDefense Get-Clipboard
        This command will run the function against whatever is in the clipboard. This is
        useful if you use the "Copy Hyerlink" feature of Outlook to get the URL to test.
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .NOTES
        Updated by Steven Judd on 2020/03/10 to:
            Add Help block
            Add sending a value to Url from the pipeline
            Set the Url parameter to an array
            Added the begin,process,end blocks to properly handle pipeline input
            Added the "urldefense.com" check to the Select-String RegEx and used capture groups to get just the URL
    #>

    param (
        [Parameter(
            Mandatory,
            ValuefromPipeline
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$Url
    ) 

    begin { }
    
    process {
        foreach ($item in $Url) {
            $UrlDefenseUrl = $item | Select-String "(urldefense\.com).*?(__.*__)"
            if ($UrlDefenseUrl) {
                $UrlWithDelimiter = ($UrlDefenseUrl | Select-Object -ExpandProperty Matches | Select-Object -ExpandProperty Groups)[2].Value
                #remove the delimiters at the beginning and end of the Url
                if ($UrlWithDelimiter.Substring(0, 2) -eq "__") {
                    $UrlWithDelimiter = $UrlWithDelimiter.Substring(2)
                }
                if ($UrlWithDelimiter.Substring($UrlWithDelimiter.Length - 2) -eq "__") {
                    ($UrlWithDelimiter).SubString(0, ($UrlWithDelimiter).Length - 2)
                }
            } #end if $UrlDefenseUrl
            else {
                Write-Error "Url is not from urldefense.com and does not contain the proper double-underscore delimiters"
            }
        } #end foreach $item in $Url
    } #end process block

    end { }
} #end Get-sjUrlFromUrlDefense function

# test cases:
# Get-OriginalUrlFromUrlDefense
# Get-OriginalUrlFromUrlDefense -Url "https://urldefense.com/v3/__https://github.com/stevenjudd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"
# $Url = "https://urldefense.com/v3/__https://github.com/stevenjudd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"
# $Url | Get-OriginalUrlFromUrlDefense
# Get-OriginalUrlFromUrlDefense -Url ""
# Get-OriginalUrlFromUrlDefense "blah"
