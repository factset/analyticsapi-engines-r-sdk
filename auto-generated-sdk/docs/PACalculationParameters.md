# factset.analyticsapi.engines::PACalculationParameters

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**componentid** | **character** | The PA Engine component identifier to analyze. | 
**accounts** | [**array[PAIdentifier]**](PAIdentifier.md) | List of accounts. | [optional] 
**benchmarks** | [**array[PAIdentifier]**](PAIdentifier.md) | List of benchmarks. | [optional] 
**dates** | [**PADateParameters**](PADateParameters.md) |  | [optional] 
**groups** | [**array[PACalculationGroup]**](PACalculationGroup.md) | List of groupings for the PA calculation. This will take precedence over the groupings saved in the PA document. | [optional] 
**currencyisocode** | **character** | Currency ISO code for calculation. | [optional] 
**columns** | [**array[PACalculationColumn]**](PACalculationColumn.md) | List of columns for the PA calculation. This will take precedence over the columns saved in the PA document. | [optional] 
**componentdetail** | **character** | Component detail type for the PA component. It can be GROUPS or TOTALS. | [optional] 


