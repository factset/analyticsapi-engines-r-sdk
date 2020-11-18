# factset.analyticsapi.engines::FIABCalculationParameters

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**fiabdocument** | **character** | FiabDocument (optional) - FIAB document to use as a template. Should  be a path to a FIAB document. Expects a GUI-style path (Client:/foo/bar) | [optional] 
**account** | [**FIABIdentifier**](FIABIdentifier.md) |  | 
**dates** | [**FIABDateParameters**](FIABDateParameters.md) |  | 
**msl** | **character** | Master Security List. Analytics results will be written to the selected MSL. Expects a GUI-style path (Client:/foo/bar) | [optional] 
**fisettingsdocument** | **character** | FISettingsDocument (optional) - The given @FIS document will be used to  configure analytics assumptions and settings. Expects a GUI-style path (Client:/foo/bar) | [optional] 


