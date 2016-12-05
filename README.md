#GoCardless Pro CFML client library
A CFML library for interacting with the [GoCardless](https://gocardless.com/) Direct Debit payment [API](https://developer.gocardless.com/). 

##Features

All of the [Core Endpoints](https://developer.gocardless.com/api-reference/#core-endpoints) are supported, including the [Redirect Flow](https://developer.gocardless.com/api-reference/#core-endpoints-redirect-flows).

##Limitations

The [Whitelabel Partner Endpoints](https://developer.gocardless.com/api-reference/#whitelabel-partner-endpoints) are not supported.

##Requirements

[Lucee Server](http://lucee.org/) 4.5 or later

OR

Adobe ColdFusion 11 or later.

##Initialisation

Instances of the library can be created as needed, or you can store a singleton in the application scope.

You will need to pass in your GoCardless API Developer access token and specify whether the environment is *sandbox* (the default) or *production*.

```
gocardless = New gocardless( access_token="your_access_token_here", environment="sandbox" );
```

##Return values

To provide flexibility and make it easier to test and debug, each method returns a struct containing details of how the library has processed your input as well as the returned data in both its raw json and de-serialised form.

Each request returns a struct with the following keys:
- `requestMethod`: GET, PUT or POST
- `requestUrl`: The actual url used by the library for the API request
- `httpResponse`: the http result struct containing the headers and other details returned
- `requestSucceeded`: boolean indicating whether or not GoCardless successfully processed the request (see below for error return values)
- `bodyReceived`: the raw json body received from GoCardless
- `data`: the returned json body de-serialised into a CFML struct

Other keys may be present depending on the type of request:
- `requestBody`: the json parameters sent
- `resource`: a single returned resource CFML struct returned by the API, e.g. Customer
- `idemPotencyKey`: if specified when creating a resource

If GoCardless returns an error, the following keys will normally be present:
- `error`: a string description of the http status code and API error message
- `data.error`: a CFML struct containing the full error object returned by GoCardless

##Usage/Examples

Basic examples of how to call the API methods using the CFML library are provided in the [wiki](https://github.com/cfsimplicity/gocardless-pro-cfml/wiki). For full details of the API including optional parameters, see the [GoCardless API documentation](https://developer.gocardless.com/api-reference).

##Test Suite
The automated tests require [TestBox 2.3](https://github.com/Ortus-Solutions/TestBox) or later. You will need to create an application mapping for `/testbox`

##Legal

###The MIT License (MIT)

Copyright (c) 2016 Julian Halliwell

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.