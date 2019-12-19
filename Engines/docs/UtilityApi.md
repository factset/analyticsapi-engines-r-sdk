# UtilityApi

All URIs are relative to *https://api.factset.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GetByUrl**](UtilityApi.md#GetByUrl) | **GET** {url} | Get by url

# **GetByUrl**
> raw GetByUrl(url)

Get by url

This method fetches data from any GET endpoint.

### Example
```R
library(factset.analyticsapi.engines)

var.url <- `url_example` # character | Url of the GET endpoint

#This function can be used to fetch data from any Get endpoint.
api.instance <- UtilityApi$new()
# Configure HTTP basic authorization: Basic
api.instance$apiClient$username <- 'TODO_YOUR_USERNAME';
api.instance$apiClient$password <- 'TODO_YOUR_PASSWORD';
result <- tryCatch(
             api.instance$GetByUrl(var.url),
             ApiException = function(ex) ex 
          )
# In case of error, print the error object 
if(!is.null(result$ApiException)) {
  cat(result$ApiException$toString())
 } else {
# deserialized response object
response.object <- result$content
# response headers
response.headers <- result$response$headers
# response status code
response.status.code <- result$response$status_code
}
```

### Parameters
This endpoint does not need any parameter.
Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **character**| Get by url | 

### Return type

**raw**

### Authorization

[Basic](../README.md#Basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/x-protobuf, text/plain, application/json, text/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Expected response once the request is successful. Response body will contain the data. |  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * Age - Standard HTTP header. Header will specify the age of columns list cached response. <br>  * X-DataDirect-Request-Key - FactSet's request key header. <br>  |
| **400** | Invalid identifier provided. |  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-DataDirect-Request-Key - FactSet's request key header. <br>  |
| **401** | Missing or invalid authentication. |  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-DataDirect-Request-Key - FactSet's request key header. <br>  |
| **403** | User is forbidden with current credentials |  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-DataDirect-Request-Key - FactSet's request key header. <br>  |
| **406** | Unsupported Accept header. Header needs to be set to application/json. |  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-DataDirect-Request-Key - FactSet's request key header. <br>  |
| **500** | Server error. Log the X-DataDirect-Request-Key header to assist in troubleshooting. |  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-DataDirect-Request-Key - FactSet's request key header. <br>  |
| **503** | Request timed out. Retry the request in sometime. |  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-DataDirect-Request-Key - FactSet's request key header. <br>  |
