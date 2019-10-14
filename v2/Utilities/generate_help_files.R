# This script is for generating .html help files by generating the man files using roxygen comments
# This script should be executed from the vVERSION folder Ex: inside the v1/ directory

# command example:
# Rscript Utilities/generate_help_files.R --domain factset.analyticsapi --projectname paengineapi --apiversion v1 --packageversion 1.0.0

library(getopt)

# defining the command line argument flags
spec = matrix(c(
  'domain',         'd', 1, "character",
  'projectname',    'n', 1, "character",
  'apiversion',     'v', 1, "character",
  'packageversion', 'p', 1, "character"
), byrow=TRUE, ncol=4)

# Reading command line arguments using "getopt" library
argList = getopt(spec)

# Creating .Rd files using the roxygen comments, by default dumps the files to "man" folder
roxygen2::roxygenize(roclets = c("rd", "namespace"), package.dir = argList$projectname)

dir = getwd()
dir_man = file.path(dir, argList$projectname,"man")

files = list.files(dir_man, full.names = T)
pkg = paste(argList$domain, ".",argList$projectname, ".", argList$apiversion, sep = "")
links = tools::findHTMLlinks()
f = force(links)

# Creating help directory inside the $projectname folder
help.dir.path <- file.path(dir, argList$projectname, "help")
dir.create(help.dir.path)

# Dumping generated .html files into $projectname/help directory 
for (file in files) {
  outFile = gsub(".Rd",".html",file)
  outFile = gsub(dir_man, help.dir.path, outFile)
  tools::Rd2HTML(Rd = file, outFile, package = pkg, Links = links, no_links = F)
}

# output zip file name in the format "$domain.$projectname.$apiversion_$packageversion.docs.zip"
output.zip <- file.path(dir, argList$projectname, paste(pkg, "_", argList$packageversion,".docs", ".zip", sep = ""))

setwd(help.dir.path)
files2zip <- dir(help.dir.path, full.names = FALSE)

# Creating .zip file 
# commenting out below line as moving the zip file creation part to jenkins job
#zip(zipfile = output.zip, files = files2zip)