<img alt="FactSet" src="https://www.factset.com/hubfs/Assets/images/factset-logo.svg" height="56" width="290">

# Analytics API V3 R Programming Code Snippets

To integrate with FactSet's Analytics APIs. Code snippets are available for below APIs

* [PA Engine API](https://developer.factset.com/api-catalog/pa-engine-api)


## Requirements

* R-4.1.0 or higher

## Installation

* Install from CRAN:

  ```sh
  
   Rscript -e "install.packages('factset.protobuf.stach.v2', repos = 'http://cran.us.r-project.org')"
   Rscript -e "install.packages('factset.protobuf.stachextensions', repos = 'http://cran.us.r-project.org')"
  ```

## Usage

Refer [examples](examples) project for sample code snippets to quickly get started.


## Prerequisite

* Set the environment variables as below. Use the [Developer Portal Manage API Keys page](https://developer.factset.com/manage-api-keys) to get these values.

```r
Sys.setenv("ANALYTICS_API_URL" = "https://api.factset.com")
Sys.setenv("ANALYTICS_API_USERNAME_SERIAL" = "<username-serial>")
Sys.setenv("ANALYTICS_API_PASSWORD" = "<apikey>")
```

## Contributing

* Projects [examples](examples) are open to enhancements and bug fixes. Please create a pull requests with the proposed changes.