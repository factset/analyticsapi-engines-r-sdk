# analyticsapi-engines-r-sdk

## Overview:
API client library to leverage FactSet's PA Engine, SPAR Engine and Vault API in R.

**`Engines`** - Contains the R API client library. It is developed using [open-api-generator](https://github.com/OpenAPITools/openapi-generator).

**`Utilities`** - Contains the EnginesAPI's OpenAPI schema(openapi-schema.json), configuration file(openapi-generator-config.json), custom OpenAPI templates, examples and End-to-End tests of library.

#### Current versions:
* API_VERSION - 2
* PACKAGE_VERSION - 3.0.0

## To install the API client library:
```r
install.packages("factSet.analyticsapi.engines.PACKAGE_VERSION")
```

## Generating the R library:
To customize OpenAPI generator options and generate the library.

### Prerequisites:
* Install [Java SDK8 64 bit version](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).
* Install R and RStudio.
* Clone this `analyticsapi-engines-r-sdk` repository.
* Move into the `analyticsapi-engines-r-sdk/Utilities/codegen` directory and run the `download-codegen.bat` file by double clicking it (for downloading the openapi-generator-cli.jar).

### Generate library:
* Move to the `analyticsapi-engines-r-sdk` location.
* Increment the package version in `Utilities/codegen/openapi-generator-config.json`.
* Delete all the files in the Engines directory excluding `.openapi-generator-ignore` file.
* Replace PACKAGE_VERSION in the below command with its latest value and run it.
```r
javac -classpath Utilities/codegen/*; Utilities/codegen/CustomRClientCodegen.java
java -DapiTests=false -DmodelTests=false -classpath Utilities/codegen/;Utilities/codegen/*; org.openapitools.codegen.OpenAPIGenerator generate --generator-name CustomRClientCodegen --input-spec Utilities/codegen/openapi-schema.json --output Engines --config Utilities/codegen/openapi-generator-config.json --template-dir Utilities/codegen/templates --http-user-agent "engines-api/PACKAGE_VERSION/r" --skip-validate-spec
```
* On successful run of the above command, the R library files will be generated.
* Run the below command to build the package from `analyticsapi-engines-r-sdk`.This will generate the .tar.gz file that is the source package which should be distributed for installation.
```r
R CMD build Engines
```

### Run Tests:

#### Prerequisite:
Should have the `testthat` package installed for running end-to-end tests.

#### Running the tests using RStudio:
* Open RStudio and open a new R script.
* Set the working directory to the `analyticsapi-engines-r-sdk` directory using the setwd() command.
```r
setwd("/path/to/analyticsapi-engines-r-sdk")
```
* Set the environment variables as below.
```r
Sys.setenv("ANALYTICS_API_URL" = "https://api.factset.com")
Sys.setenv("ANALYTICS_API_USERNAME_SERIAL" = "<username-serial>")
Sys.setenv("ANALYTICS_API_PASSWORD" = "<apikey>") # Generate using [developer portal](https://developer.factset.com/)
```

* Source the testthat.R file for running the tests using the below command.
```r
source("Utilities/tests/testthat.R")
```