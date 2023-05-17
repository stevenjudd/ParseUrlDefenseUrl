# an example URL protected by URL Defense
$url = 'https://urldefense.com/v3/__https://github.com/stevenjudd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$'
# making sure the URL is pulled from the variable using the double-underscore
$url | sls '__.*?__'
# check what is contained in the object returned by sls
$url | sls '__.*?__' | gm -MemberType Property | select Name, MemberType, Definition | ft
# looking inside the Matches property
$url | sls '__.*?__' | select matches
# whoops. It is an object. Need to expand the object
$url | sls '__.*?__' | select -ExpandProperty matches
# Did you know this will expand the property?
$url | sls '__.*?__' | % matches
# the Value property has the URL
$url | sls '__.*?__' | % matches | select value
# return just the value property contents
($url | sls '__.*?__' | % matches).value
# remove the double-underscores
($url | sls '__.*?__' | % matches).value -replace '__', ''
# a potential problem would be if the URL had double-underscores inside the outside double-underscores
# this would break the URL, so only the first and last set should be removed
# Let's test that by adding double-underscores to the URL
$url2 = 'https://urldefense.com/v3/__https://github.com/steven__judd/sjUrlDefense__;!!J9_hdUX_JbjuLQ!_mpQgRsIaawOILsUWxCcr5y3kFNhQir7iT8vEvcJzL8J4OfrN2b3ichHNbkMj4c$'
# make sure the sls still works
$url2 | sls '__.*?__'
# check the value
($url2 | sls '__.*?__' | % matches).value
# oops. There is a problem with the RegEx. Need to fix that first.
# remember the previous command:
# ($url2 | sls "__.*?__" | % matches).value
($url2 | sls '__.*__' | % matches).value
# now for the replace (and failure...)
# it removes all of the double-underscores, which will break the URL
($url2 | sls '__.*__' | % matches).value -replace '__', ''
# to fix this, use substring to remove the first 2 and last 2 characters
# we know the url will start and end with 2 underscores
# because that's what matches our regex
($url2 | sls '__.*__' | % matches).value.substring(2, ($url2 | sls '__.*__' | % matches).length - 4)
# or you don't like to expand properties so you call them directly
($url2 | sls '__.*__').matches.value.substring(2, ($url2 | sls '__.*__').matches.value.length - 4)
# or you don't like running the sls twice so you use OutVariable
($url2 | sls '__.*__' -OutVariable SearchResult | % matches).value.substring(2, ($SearchResult | % matches).length - 4)
# or (if you are a single-line command cheater...)
$SearchScope = $url2 | sls '__.*__' ; $SearchScope.matches.value.substring(2, $SearchScope.matches.value.length - 4)
# but seriously, use this (-ov is the alias for -OutVariable)
($url2 | sls '__.*__' -ov result).matches.value.substring(2, $result.matches.length - 4)
# The end