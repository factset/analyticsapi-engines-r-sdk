# factset.analyticsapi.engines::CalculationStatus

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**status** | **character** |  | [optional] 
**units** | **integer** | Number of calculation units in batch. | [optional] 
**pa** | [**map(CalculationUnitStatus)**](CalculationUnitStatus.md) | List of statuses for PA calculation units. | [optional] 
**spar** | [**map(CalculationUnitStatus)**](CalculationUnitStatus.md) | List of statuses for SPAR calculation units. | [optional] 
**vault** | [**map(CalculationUnitStatus)**](CalculationUnitStatus.md) | List of statuses for Vault calculation units. | [optional] 
**pub** | [**map(CalculationUnitStatus)**](CalculationUnitStatus.md) | List of statuses for Publisher calculation units. | [optional] 


