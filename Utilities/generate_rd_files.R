# This script is used for generating .rd files from the roxygen comments
# This script should be executed from the analyticsapi-engines-r-sdk directory

# command example:
# Rscript Utilities/generate_rd_files.R --projectname Engines

library(getopt)

# defining the command line argument flags
spec = matrix(c(
  'projectname', 'n', 1, "character"
), byrow=TRUE, ncol=4)

# Reading command line arguments using "getopt" library
argList = getopt(spec)

# Creating .Rd files using the roxygen comments, by default dumps the files to "man" folder
roxygen2::roxygenize(roclets = c("rd", "namespace"), package.dir = argList$projectname)