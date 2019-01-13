##############################
# UK PETITIONS MAP * prep up #
##############################

# load packages
pkgs <- c('data.table', 'readxl', 'rgdal')
lapply(pkgs, require, char = TRUE)

# set constants
tmp <- tempfile()
tmp.xls <- tempfile(fileext = ".xls")
tmpdir <- 'tmp_pet'

# download boundaries, and save locally
download.file('https://opendata.arcgis.com/datasets/5ce27b980ffb43c39b012c2ebeab92c0_2.zip', tmp)
unzip(tmp, exdir = tmpdir)
y <- list.files(tmpdir, 'shp')
bnd <- readOGR(tmpdir, sub('\\.shp$', '', y[grepl('Constituencies', y)]))
bnd <- bnd[, 1:2]
saveRDS(bnd, '~/shinyapps/uk_petitions/boundaries')

# download election data
download.file(
    'https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/elections/electoralregistration/datasets/electoralstatisticsforuk/2017unformatted/elec5dt2unformattedelectoralstatisticsuk2017.xls',
    destfile = tmp.xls,
    mode = 'wb'
)
electors <- as.data.table(read_xls(tmp.xls, sheet = 5))
electors <- electors[, c(1, 5)]
saveRDS(electors, '~/shinyapps/uk_petitions/electors')

# clean
unlink(tmp)
unlink(tmp.xls)
unlink(tmpdir, recursive = TRUE)

