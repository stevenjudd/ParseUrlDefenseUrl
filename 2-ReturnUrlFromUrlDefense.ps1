#this script is intended to run after copying the URL to the clipboard from a defended email
#the next line is for testing
#Set-Clipboard -Value "https://urldefense.com/v3/__https://github.com/stevenjudd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$"

#get URL from clipboard
$url = Get-Clipboard
if (-not($url)) {
  Write-Error 'Nothing in the clipboard. Please copy the URL Defense string to parse into the clipboard before running the script.'
  return
}
($url | Select-String '__.*__' -OutVariable SearchResult).Matches.Value.SubString(2, $SearchResult.Matches.Length - 4)
