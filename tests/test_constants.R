library(factset.analyticsapi.engines)
library(httr)

username <- Sys.getenv("ANALYTICS_API_USERNAME_SERIAL")
password <- Sys.getenv("ANALYTICS_API_PASSWORD")
url <- if(Sys.getenv("ANALYTICS_API_URL") == "") "https://api.factset.com" else Sys.getenv("ANALYTICS_API_URL")

pa_document <- "PA_DOCUMENTS:DEFAULT"
pa_account1 <- PAIdentifier$new(id = "BENCH:SP50")
pa_account2 <- PAIdentifier$new(id = "BENCH:R.2000")
pa_benchmark1 <- PAIdentifier$new(id = "BENCH:R.2000")
pa_dates <- PADateParameters$new(startdate = "20180601", enddate = "20181231", frequency = "Monthly")

spar_document <- "SPAR_DOCUMENTS:Factset Default Document"
spar_account1 <- SPARIdentifier$new(id = "R.1000", returntype = "GTR", prefix = "RUSSELL")
spar_account2 <- SPARIdentifier$new(id = "R.2000", returntype = "GTR", prefix = "RUSSELL")
spar_benchmark <- SPARIdentifier$new(id = "R.2000", returntype = "GTR", prefix = "RUSSELL")
spar_dates <- SPARDateParameters$new(startdate = "20180101", enddate = "20181231", frequency = "Monthly")

vault_document <- "PA3_DOCUMENTS:DEFAULT"
vault_account <- VaultIdentifier$new(id = "Client:/analytics/data/US_MID_CAP_CORE.ACTM")
vault_dates = VaultDateParameters$new(startdate = "20190830", enddate = "20190904", frequency = "Monthly")

lookup_directory = "client:"

start_date = "-1M"
end_date = "-1d"
account = "CLIENT:Analytics_api/test_account_do_not_delete.acct"

apiClient <- ApiClient$new(basePath = url, username = username, password = password)

