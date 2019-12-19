library(factset.protobuf.stach)

# The purpose of this class is to provide the helper methods for converting stach to Tabular format
StachExtension <- R6::R6Class(
  "StachExtension",
  public = list(
    generateCSV = function(package) {
      dataFramesList <- self$convertToDataFrame(package)
      for (dataFrameId in names(dataFramesList)) {
        write.table(dataFramesList[[dataFrameId]], file = paste(dataFrameId, ".csv", sep = ""), sep = ",", row.names = FALSE)
      }
    },

    convertToDataFrame = function(package) {
      dataFramesList <- list()
      for (primaryTableid in package$primary_table_ids) {
        df <- self$generateTable(package, primaryTableid)
        dataFramesList[[primaryTableid]] <- df
      }
      dataFramesList
    },

    generateTable = function(package, primaryTableId) {
      seriesDataHelper <- SeriesDataHelper$new()
      primaryTable <- self$getMappingObject(package$tables, primaryTableId)$value
      headerTableId <- primaryTable$definition$header_table_id
      headerTable <- self$getMappingObject(package$tables, headerTableId)$value
      columnIds <- lapply(primaryTable$definition$columns, function(seriesDef) seriesDef$id)
      headerColumnIds <- lapply(headerTable$definition$columns, function(seriesDef) seriesDef$id)
      dimensionColPositions <- sapply(primaryTable$definition$columns, function(seriesDef) {
        seriesDef$is_dimension
      })
      dimensionColumns <- primaryTable$definition$columns[dimensionColPositions]
      dimensionColumnsCount <- sum(dimensionColPositions, na.rm = TRUE)
      rowCount <- length(primaryTable$data$rows)
      headerRowCount <- length(headerTable$data$rows)
      headers <- list()
      # Constructs the column headers by considering dimension columns and header rows
      for (columnid in headerColumnIds) {
        for (i in 1:dimensionColumnsCount) {
          headers <- append(headers, dimensionColumns[[i]]$description)
        }

        for (i in 1:headerRowCount) {
          seriesData <- self$getMappingObject(headerTable$data$columns, columnid)$value
          seriesDefinitionColumn <- self$getMappingObject(headerTable$definition$columns, columnid, keyname = "id")
          headers <- append(headers, seriesDataHelper$getValueHelper(seriesData = seriesData, datatype = seriesDefinitionColumn$type, index = i, seriesFormat = seriesDefinitionColumn$format))
        }
      }

      headers <- unlist(headers)
      headerdataMatrix <- matrix(headers, ncol = length(columnIds), byrow = TRUE)
      headerdataFrame <- data.frame(headerdataMatrix, stringsAsFactors = FALSE)

      data <- list()
      # Constructs the column data
      for (columnid in columnIds) {
        seriesData <- self$getMappingObject(primaryTable$data$columns, columnid)$value
        seriesDefinitionColumn <- self$getMappingObject(primaryTable$definition$columns, columnid, keyname = "id")
        columnData <- seriesDataHelper$getValueHelper(seriesData = seriesData, datatype = seriesDefinitionColumn$type, index = 1:rowCount, seriesFormat = seriesDefinitionColumn$format)
        data <- append(data, columnData)
      }
      data <- unlist(data)
      dataMatrix <- matrix(data, ncol = length(columnIds), byrow = FALSE)
      dataFrame <- data.frame(dataMatrix, stringsAsFactors = FALSE)

      # As R data frame is not supporting multi-row column headers, combining the multi-row headers into a single row header with an underscore seperation.
      header <- NULL
      for (n in 1:ncol(headerdataFrame)) {
        header <- append(header, paste(headerdataFrame[, n], collapse = "_"))
      }

      names(dataFrame) <- header
      dataFrame
    },

    # Helper method for getting the value corresponding to the given key from the object.
    getMappingObject = function(objectMap, key, keyname = "key") {
      for (obj in objectMap) {
        if (obj[[keyname]] == key) {
          return(obj)
        }
      }
    }
  )
)

# This class provides helper method for returning the data from the SeriesData object by handling the null values.
SeriesDataHelper <- R6::R6Class(
  "SeriesDataHelper",
  public = list(
    getValueHelper = function(seriesData, datatype, index, seriesFormat) {
      Datatype <- factset.protobuf.stach.table.DataType
      nullValues <- factset.protobuf.stach.NullValues$new()
      returnValue <- NULL

      if (datatype == Datatype$STRING) {
        returnValue <- seriesData$string_array$values[index]
        returnValue <- replace(returnValue, returnValue == nullValues$STRING, seriesFormat$null_format)
      } else if (datatype == Datatype$DOUBLE) {
        returnValue <- seriesData$double_array$values[index]
        returnValue <- replace(returnValue, is.nan(returnValue), seriesFormat$null_format)
      } else if (datatype == Datatype$FLOAT) {
        returnValue <- seriesData$float_array$values[index]
        returnValue <- replace(returnValue, is.nan(returnValue), seriesFormat$null_format)
      } else if (datatype == Datatype$INT32) {
        returnValue <- seriesData$int32_array$values[index]
        returnValue <- replace(returnValue, returnValue == nullValues$INT32, seriesFormat$null_format)
      } else if (datatype == Datatype$INT64) {
        returnValue <- seriesData$int64_array$values[index]
        returnValue <- replace(returnValue, returnValue == nullValues$INT64, seriesFormat$null_format)
      } else if (datatype == Datatype$BOOL) {
        returnValue <- seriesData$bool_array$values[index]
      } else if (datatype == Datatype$DURATION) {
        returnValue <- seriesData$duration_array$values[index]
        returnValue <- replace(returnValue, returnValue == nullValues$DURATION, seriesFormat$null_format)
      } else if (datatype == Datatype$TIMESTAMP) {
        returnValue <- seriesData$timestamp_array$values[index]
        returnValue <- replace(returnValue, returnValue == nullValues$TIMESTAMP, seriesFormat$null_format)
      } else {
        stop("The datatype is not implemented")
      }
      returnValue
    }
  )
)
