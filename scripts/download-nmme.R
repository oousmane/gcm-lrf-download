source("functions/ftp_dir_ls.R")

# Download Hindcast forecast SST

fcst_dir <- "ftp.cpc.ncep.noaa.gov/International/nmme/monthly_nmme_forecast_in_cpt_format/"
hcst_dir <- "ftp.cpc.ncep.noaa.gov/International/nmme/monthly_nmme_hindcast_in_cpt_format/"

# create  data directories
if(!fs::dir_exists("nmme_mayic_data/")) fs::dir_create("nmme_mayic_data/")
if(!fs::dir_exists("nmme_mayic_data/fcst/")) fs::dir_create("nmme_mayic_data/fcst/")
if(!fs::dir_exists("nmme_mayic_data/hcst/")) fs::dir_create("nmme_mayic_data/hcst/")

# get files url 

fcst_files <- ftp_dir_ls(ftp = fcst_dir,pattern = "(?:sst|precip)_.*_Mayic_[0-9]_2024")
fcst_url_files <- paste0(fcst_dir,fcst_files)
fcst_dest_files <- paste0("nmme_mayic_data/fcst/",fcst_files)

hcst_files <- ftp_dir_ls(ftp = hcst_dir,pattern = "(?:sst|precip)_.*_Mayic_[0-9]_1991")
hcst_url_files <- paste0(hcst_dir,hcst_files)
hcst_dest_files <- paste0("nmme_mayic_data/hcst/",hcst_files)

print("#------- Download NMME Monthly forecast data --------#")
purrr::walk2(
  .x = fcst_url_files,
  .y = fcst_dest_files,
  .f = curl::curl_download
)

print("#------- Download NMME Monthly hindcast data --------#")

purrr::walk2(
  .x = hcst_url_files,
  .y = hcst_dest_files,
  .f = curl::curl_download
)
