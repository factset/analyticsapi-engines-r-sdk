<img alt="FactSet" src="https://www.factset.com/hubfs/Assets/images/factset-logo.svg" height="56" width="290">

# Analytics API Engines R SDK

[![build](https://img.shields.io/github/workflow/status/factset/analyticsapi-engines-r-sdk/CI)](https://github.com/factset/analyticsapi-engines-r-sdk/actions?query=workflow%3ACI)
[![cran](https://img.shields.io/cran/v/factset.analyticsapi.engines)](https://cran.r-project.org/web/packages/factset.analyticsapi.engines)
![API version](https://img.shields.io/badge/API-v2-blue)
[![Apache-2 license](https://img.shields.io/badge/license-Apache2-brightgreen.svg)](https://www.apache.org/licenses/LICENSE-2.0)

Use this library to integrate with FactSet's Analytics APIs. Below APIs are supported by this SDK.

* [PA Engine API](https://developer.factset.com/api-catalog/pa-engine-api)
* [SPAR Engine API](https://developer.factset.com/api-catalog/spar-engine-api)
* [Vault API](https://developer.factset.com/api-catalog/vault-api)

## Contents

* [auto-generated-sdk](auto-generated-sdk) - Auto-generated code using [Analytics API Engines SDK Generator](https://github.com/factset/analyticsapi-engines-sdk-generator)
* [examples](examples) - Sample project containing code snippets to quickly get started with the SDK  
* [tests](tests) - Integration tests

## Requirements

* R-3.5.3 or higher

## Installation

* Install from CRAN:

  ```sh
  Rscript -e "install.packages('factset.analyticsapi.engines', repos = 'http://cran.us.r-project.org')"
  ```

* Alternatively, download or clone this repository and build the SDK:

  ```sh
  git clone https://github.com/factset/analyticsapi-engines-r-sdk.git
  R CMD build auto-generated-sdk
  ```

## Usage

Refer [examples](examples) project for sample code snippets to quickly get started with the SDK

## Tests

### Prerequisite

`testthat` - For running end-to-end tests

#### Running the tests using RStudio

* Open RStudio and open a new R script.

* Set the working directory to the `analyticsapi-engines-r-sdk` directory using the setwd() command.

```r
setwd("/path/to/analyticsapi-engines-r-sdk")
```

* Set the environment variables as below. Use the [Developer Portal Manage API Keys page](https://developer.factset.com/manage-api-keys) to get these values.

```r
Sys.setenv("ANALYTICS_API_URL" = "https://api.factset.com")
Sys.setenv("ANALYTICS_API_USERNAME_SERIAL" = "<username-serial>")
Sys.setenv("ANALYTICS_API_PASSWORD" = "<apikey>")
```

## Contributing

* Files in [auto-generated-sdk](auto-generated-sdk) directory are auto-generated and should not be manually edited here. Refer [Analytics API Engines SDK Generator](https://github.com/factset/analyticsapi-engines-sdk-generator) for instructions on how to modify these files.
* Projects [examples](examples) and [tests](tests) are open to enhancements and bug fixes. Please create a pull requests with the proposed changes.
