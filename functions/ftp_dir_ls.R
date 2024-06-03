#' List the files in a FTP (remote) directory/folder
#' @description
#' This function produce a character vector of the names of files in the ftp folder provided
#' 
#' @param ftp FTP base directory/folder 
#' @param pattern an optional regular expression. Only file names which match the regular expression will be returned.
#' @author Adam H. Sparks, Ousmane Ouedraogo
#'
#' @return character vector of the names of files in FTP base directory
#' @export
#'
#' @examples
#' ftp_base <- "ftp.cpc.ncep.noaa.gov/International/nmme/seasonal_nmme_forecast_in_cpt_format/"
#' ftp_files <- ftp_dir_ls(ftp = ftp_base)
#' ftp_files[1:10]
#' 
ftp_dir_ls <- function(ftp, pattern=NULL)
  {
  list_files <- curl::new_handle()
  curl::handle_setopt(
    list_files, 
    ftp_use_epsv = TRUE,
    dirlistonly = TRUE
    )
  con <- curl::curl(
    url = ftp,
    "r", 
    handle = list_files)
  
  

if (is.null(pattern)){
  files <- readLines(con)
} else {
  files <- readLines(con)
  files <- files[stringr::str_detect(files, pattern = pattern)]
}
close(con)
return(files)

}

