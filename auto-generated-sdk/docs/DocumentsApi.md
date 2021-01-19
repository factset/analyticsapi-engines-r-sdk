# DocumentsApi

All URIs are relative to *https://api.factset.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GetPA3Documents**](DocumentsApi.md#GetPA3Documents) | **GET** /analytics/lookups/v2/engines/pa/documents/{path} | Get PA3 documents and sub-directories in a directory
[**GetPubDocuments**](DocumentsApi.md#GetPubDocuments) | **GET** /analytics/lookups/v2/engines/pub/documents/{path} | Gets Publisher documents and sub-directories in a directory
[**GetSPAR3Documents**](DocumentsApi.md#GetSPAR3Documents) | **GET** /analytics/lookups/v2/engines/spar/documents/{path} | Gets SPAR3 documents and sub-directories in a directory
[**GetVaultDocuments**](DocumentsApi.md#GetVaultDocuments) | **GET** /analytics/lookups/v2/engines/vault/documents/{path} | Get Vault documents and sub-directories in a directory


# **GetPA3Documents**
> DocumentDirectories GetPA3Documents(path)

Get PA3 documents and sub-directories in a directory

This endpoint looks up all PA3 documents and sub-directories in a given directory.

### Example
```R
library(factset.analyticsapi.engines)

var.path <- '' # character | The directory to get the documents and sub-directories in

#Get PA3 documents and sub-directories in a directory
api.instance <- DocumentsApi$new()
# Configure HTTP basic authorization: Basic
api.instance$apiClient$username <- 'TODO_YOUR_USERNAME';
api.instance$apiClient$password <- 'TODO_YOUR_PASSWORD';
result <- tryCatch(
             api.instance$GetPA3Documents(var.path),
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
 **path** | **character**| The directory to get the documents and sub-directories in | [default to &#39;&#39;]

### Return type

[**DocumentDirectories**](DocumentDirectories.md)

### Authorization

[Basic](../README.md#Basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Expected response, returns a list of PA3 documents and directories |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **400** | Invalid query parameter or value provided |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **401** | Missing or invalid authentication |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **403** | User is forbidden with current credentials |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **404** | Path not found |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **406** | Unsupported Accept header.  Header needs to be set to application/json |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **429** | Rate limit reached. Wait till the time specified in Retry-After header value to make further requests. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * Retry-After - Time to wait in seconds before making a new request as the rate limit has reached. <br>  |
| **500** | Server error. Log the X-DataDirect-Request-Key header to assist in troubleshooting |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **503** | Request timed out. Retry the request in some time |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |

# **GetPubDocuments**
> DocumentDirectories GetPubDocuments(path)

Gets Publisher documents and sub-directories in a directory

This endpoint looks up all Publisher documents and sub-directories in a given directory.

### Example
```R
library(factset.analyticsapi.engines)

var.path <- '' # character | The directory to get the documents in

#Gets Publisher documents and sub-directories in a directory
api.instance <- DocumentsApi$new()
# Configure HTTP basic authorization: Basic
api.instance$apiClient$username <- 'TODO_YOUR_USERNAME';
api.instance$apiClient$password <- 'TODO_YOUR_PASSWORD';
result <- tryCatch(
             api.instance$GetPubDocuments(var.path),
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
 **path** | **character**| The directory to get the documents in | [default to &#39;&#39;]

### Return type

[**DocumentDirectories**](DocumentDirectories.md)

### Authorization

[Basic](../README.md#Basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Expected response, returns a list of Publisher documents and directories |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **400** | Invalid query parameter or value provided |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **401** | Missing or invalid authentication |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **403** | User is forbidden with current credentials |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **404** | Path not found |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **406** | Unsupported Accept header.  Header needs to be set to application/json |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **429** | Rate limit reached. Wait till the time specified in Retry-After header value to make further requests. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * Retry-After - Time to wait in seconds before making a new request as the rate limit has reached. <br>  |
| **500** | Server error. Log the X-DataDirect-Request-Key header to assist in troubleshooting |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **503** | Request timed out. Retry the request in some time |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |

# **GetSPAR3Documents**
> DocumentDirectories GetSPAR3Documents(path)

Gets SPAR3 documents and sub-directories in a directory

This endpoint looks up all SPAR3 documents and sub-directories in a given directory.

### Example
```R
library(factset.analyticsapi.engines)

var.path <- '' # character | The directory to get the documents in

#Gets SPAR3 documents and sub-directories in a directory
api.instance <- DocumentsApi$new()
# Configure HTTP basic authorization: Basic
api.instance$apiClient$username <- 'TODO_YOUR_USERNAME';
api.instance$apiClient$password <- 'TODO_YOUR_PASSWORD';
result <- tryCatch(
             api.instance$GetSPAR3Documents(var.path),
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
 **path** | **character**| The directory to get the documents in | [default to &#39;&#39;]

### Return type

[**DocumentDirectories**](DocumentDirectories.md)

### Authorization

[Basic](../README.md#Basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Expected response, returns a list of SPAR3 documents and directories |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **400** | Invalid query parameter or value provided |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **401** | Missing or invalid authentication |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **403** | User is forbidden with current credentials |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **404** | Path not found |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **406** | Unsupported Accept header.  Header needs to be set to application/json |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **429** | Rate limit reached. Wait till the time specified in Retry-After header value to make further requests. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * Retry-After - Time to wait in seconds before making a new request as the rate limit has reached. <br>  |
| **500** | Server error. Log the X-DataDirect-Request-Key header to assist in troubleshooting |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **503** | Request timed out. Retry the request in some time |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |

# **GetVaultDocuments**
> DocumentDirectories GetVaultDocuments(path)

Get Vault documents and sub-directories in a directory

This endpoint looks up all Vault documents and sub-directories in a given directory.

### Example
```R
library(factset.analyticsapi.engines)

var.path <- '' # character | The directory to get the documents in

#Get Vault documents and sub-directories in a directory
api.instance <- DocumentsApi$new()
# Configure HTTP basic authorization: Basic
api.instance$apiClient$username <- 'TODO_YOUR_USERNAME';
api.instance$apiClient$password <- 'TODO_YOUR_PASSWORD';
result <- tryCatch(
             api.instance$GetVaultDocuments(var.path),
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
 **path** | **character**| The directory to get the documents in | [default to &#39;&#39;]

### Return type

[**DocumentDirectories**](DocumentDirectories.md)

### Authorization

[Basic](../README.md#Basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Expected response, returns a list of Vault documents and directories |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **400** | Invalid query parameter or value provided |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **401** | Missing or invalid authentication |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **403** | User is forbidden with current credentials |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **404** | Path not found |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **406** | Unsupported Accept header.  Header needs to be set to application/json |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * X-RateLimit-Limit - Number of allowed requests for the time window. <br>  * X-RateLimit-Remaining - Number of requests left for the time window. <br>  * X-RateLimit-Reset - Number of seconds remaining till rate limit resets. <br>  |
| **429** | Rate limit reached. Wait till the time specified in Retry-After header value to make further requests. |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  * Retry-After - Time to wait in seconds before making a new request as the rate limit has reached. <br>  |
| **500** | Server error. Log the X-DataDirect-Request-Key header to assist in troubleshooting |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |
| **503** | Request timed out. Retry the request in some time |  * X-DataDirect-Request-Key - FactSet&#39;s request key header. <br>  * X-FactSet-Api-Request-Key - Key to uniquely identify an Analytics API request. Only available after successful authentication. <br>  |

