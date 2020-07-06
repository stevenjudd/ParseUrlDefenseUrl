function Get-UrlDefenseUrl {
    <#
    .SYNOPSIS
        Extract the imbedded URL from a URL Defense link
    .DESCRIPTION
        This function will return the imbedded URL that is inside a URL from a URL 
        Defense link from https://urldefense.com. This makes it easier to read the 
        destination link and also to potentially load and test the URL if desired.
    .EXAMPLE
        Get-UrlDefenseUrl -Url "https://urldefense.com/v3/__https://github.com/steven__judd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"
        This command will return the imbedded URL from the specified value for the Url parameter.
    .EXAMPLE
        $Url = "https://urldefense.com/v3/__https://github.com/steven__judd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"
        $Url | Get-UrlDefenseUrl
        This command is setting the URL value to the $Url variable. This variable is 
        passed via the pipeline to the function and will return the imbedded URL.
    .EXAMPLE
        Get-UrlDefenseUrl -Url ""
        This command will return an error since the Url parameter value is empty.
    .EXAMPLE
        Get-UrlDefenseUrl "blah"
        This command will return an error since the Url parameter value does not conform
        to the urldefense format.
    .EXAMPLE
        Get-UrlDefenseUrl (Get-Clipboard)
        This command will run the function against whatever is in the clipboard. This is
        useful if you use the "Copy Hyerlink" feature of Outlook to get the URL to test.

        If you want to get fancy (of course you do) then you can run the following code
        to create a function to shortcut the above command plus a bit more:

        function furl {Get-UrlDefenseUrl -Url (Get-Clipboard) | Tee-Object -Variable url ; $url | Set-Clipboard}

        Now, after copying the UrlDefense URL to the clipboard, run "furl" to expand the
        url, output it to the console for visible examination, and copy it to the
        clipboard for pasting into a browser or another tool. (Note that this is not
        using an approved verb to keep the command as short as reasonable.)
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
        Updated by Steven Judd on 2020/03/15 to shorten the function name
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
# Get-UrlDefenseUrl
# Get-UrlDefenseUrl -Url "https://urldefense.com/v3/__https://github.com/steven__judd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"
# $Url = "https://urldefense.com/v3/__https://github.com/steven__judd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"
# $Url | Get-UrlDefenseUrl
# Get-UrlDefenseUrl -Url ""
# Get-UrlDefenseUrl "blah"
