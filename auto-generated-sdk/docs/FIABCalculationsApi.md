# FIABCalculationsApi

All URIs are relative to *https://api.factset.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GetFIABCalculationById**](FIABCalculationsApi.md#GetFIABCalculationById) | **GET** /analytics/engines/fiab/v1/calculations/{id} | Get FIAB calculation by id
[**GetFIABCalculationStatusSummaries**](FIABCalculationsApi.md#GetFIABCalculationStatusSummaries) | **GET** /analytics/engines/fiab/v1/calculations | Get all FIAB calculation summaries
[**RunFIABCalculation**](FIABCalculationsApi.md#RunFIABCalculation) | **POST** /analytics/engines/fiab/v1/calculations | Run FIAB calculation


# **GetFIABCalculationById**
> FIABCalculationStatus GetFIABCalculationById(id)

Get FIAB calculation by id

This is the endpoint to check on the progress of a previously requested calculation.

### Example
```R
library(factset.analyticsapi.engines)

var.id <- 'id_example' # character | from url, provided from the location header in the Run FIAB Calculation endpoint

#Get FIAB calculation by id
api.instance <- FIABCalculationsApi$new()
# Configure HTTP basic authorization: Basic
api.instance$apiClient$username <- 'TODO_YOUR_USERNAME';
api.instance$apiClient$password <- 'TODO_YOUR_PASSWORD';
result <- tryCatch(
             api.instance$GetFIABCalculationById(var.id),
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

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **character**| from url, provided from the location header in the Run FIAB Calculation endpoint | 

### Return type

[**FIABCalculationStatus**](FIABCalculationStatus.md)

### Authorization

[Basic](../README.md#Basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Expected response, returns status information of the entire calculation if it is complete. |  * Content-Encoding - Standard HTTP header. Header value based on Accept-Encoding Request header. <br>  * Content-Type - Standard HTTP header. <br>  * Transfer-Encoding - Standard HTTP header. Header value will be set to Chunked if Accept-Encoding header is specified. <br>  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **202** | Expected response, returns status information of the entire calculation if it is not complete. |  * Cache-Control - Standard HTTP header. Header will specify max-age in seconds. Polling can be adjusted based on the max-age value. <br>  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **400** | Invalid identifier provided. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **401** | Missing or invalid authentication. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **403** | User is forbidden with current credentials |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **404** | Calculation was already returned, provided id was not a requested calculation, or the calculation was cancelled |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **500** | Server error. Log the X-DataDirect-Request-Key header to assist in troubleshooting |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **503** | Request timed out. Retry the request in sometime. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |

# **GetFIABCalculationStatusSummaries**
> map(FIABCalculationStatusSummary) GetFIABCalculationStatusSummaries()

Get all FIAB calculation summaries

This endpoints returns all FIAB calculation requests.

### Example
```R
library(factset.analyticsapi.engines)


#Get all FIAB calculation summaries
api.instance <- FIABCalculationsApi$new()
# Configure HTTP basic authorization: Basic
api.instance$apiClient$username <- 'TODO_YOUR_USERNAME';
api.instance$apiClient$password <- 'TODO_YOUR_PASSWORD';
result <- tryCatch(
             api.instance$GetFIABCalculationStatusSummaries(),
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

### Return type

[**map(FIABCalculationStatusSummary)**](FIABCalculationStatusSummary.md)

### Authorization

[Basic](../README.md#Basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | List of active FIAB calculation requests. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **401** | Missing or invalid authentication. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **403** | User is forbidden with current credentials. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **406** | Unsupported Accept header. Header needs to be set to application/json. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **429** | Rate limit reached. Wait till the time specified in Retry-After header value to make further requests. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * Retry-After - Time to wait in seconds before making a new request as the rate limit has reached. <br>  |
| **500** | Server error. Log the X-DataDirect-Request-Key header to assist in troubleshooting. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **503** | Request timed out. Retry the request in sometime. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |

# **RunFIABCalculation**
> RunFIABCalculation(fiab.calculation.parameters=var.fiab.calculation.parameters)

Run FIAB calculation

This endpoint creates a new FIAB calculation.  This must be used first before get status or cancelling endpoints with a calculation id.  A successful response will contain the URL to check the status of the calculation request.    Remarks:  * Any settings in POST body will act as a one-time override over the settings saved in the FIAB template.

### Example
```R
library(factset.analyticsapi.engines)

var.fiab.calculation.parameters <- FIABCalculationParameters$new("fiabdocument_example", FIABIdentifier$new("id_example"), FIABDateParameters$new("startdate_example", "enddate_example"), "msl_example", "fisettingsdocument_example") # FIABCalculationParameters | 

#Run FIAB calculation
api.instance <- FIABCalculationsApi$new()
# Configure HTTP basic authorization: Basic
api.instance$apiClient$username <- 'TODO_YOUR_USERNAME';
api.instance$apiClient$password <- 'TODO_YOUR_PASSWORD';
result <- tryCatch(
             api.instance$RunFIABCalculation(fiab.calculation.parameters=var.fiab.calculation.parameters),
             ApiException = function(ex) ex 
          )
# In case of error, print the error object 
if(!is.null(result$ApiException)) {
  cat(result$ApiException$toString())
 } else {
# response headers
response.headers <- result$response$headers
# response status code
response.status.code <- result$response$status_code
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **fiab.calculation.parameters** | [**FIABCalculationParameters**](FIABCalculationParameters.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Basic](../README.md#Basic)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **202** | Expected response, contains the URL in the Location header to check the status of the calculation. |  * Location - URL to check status of the request. <br>  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-FactSet-Api-Calculations-Limit - Maximum FIAB request limit. <br>  * X-FactSet-Api-Calculations-Remaining - Number of FIAB requests remaining till request limit reached. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **400** | Invalid POST body. |  * Location - URL to check status of the request. <br>  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-FactSet-Api-Calculations-Limit - Maximum FIAB request limit. <br>  * X-FactSet-Api-Calculations-Remaining - Number of FIAB requests remaining till request limit reached. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **401** | Missing or invalid authentication. |  * Location - URL to check status of the request. <br>  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-FactSet-Api-Calculations-Limit - Maximum FIAB request limit. <br>  * X-FactSet-Api-Calculations-Remaining - Number of FIAB requests remaining till request limit reached. <br>  |
| **403** | User is forbidden with current credentials. |  * Location - URL to check status of the request. <br>  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-FactSet-Api-Calculations-Limit - Maximum FIAB request limit. <br>  * X-FactSet-Api-Calculations-Remaining - Number of FIAB requests remaining till request limit reached. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **415** | Missing/Invalid Content-Type header. Header needs to be set to application/json. |  * Location - URL to check status of the request. <br>  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-FactSet-Api-Calculations-Limit - Maximum FIAB request limit. <br>  * X-FactSet-Api-Calculations-Remaining - Number of FIAB requests remaining till request limit reached. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **429** | Rate limit reached. Cancel older requests using Cancel FIAB Calculation endpoint or wait for older requests to finish / expire. |  * Location - URL to check status of the request. <br>  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-FactSet-Api-Calculations-Limit - Maximum FIAB request limit. <br>  * X-FactSet-Api-Calculations-Remaining - Number of FIAB requests remaining till request limit reached. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  * Retry-After - Time to wait in seconds before making a new request as the rate limit has reached. <br>  |
| **500** | Server error. Log the X-DataDirect-Request-Key header to assist in troubleshooting. |  * Location - URL to check status of the request. <br>  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-FactSet-Api-Calculations-Limit - Maximum FIAB request limit. <br>  * X-FactSet-Api-Calculations-Remaining - Number of FIAB requests remaining till request limit reached. <br>  |
| **503** | Request timed out. Retry the request in sometime. |  * Location - URL to check status of the request. <br>  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-FactSet-Api-Calculations-Limit - Maximum FIAB request limit. <br>  * X-FactSet-Api-Calculations-Remaining - Number of FIAB requests remaining till request limit reached. <br>  |

