zip_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_path <- tempfile(fileext = ".zip")
out_dir <- "human_activity_dataset"

download.file(
    url = zip_url,
    destfile = zip_path,
    mode = "wb"
)

if (!dir.exists(out_dir)) {
    dir.create(out_dir, recursive = TRUE)
}

unzip(
    zipfile = zip_path,
    exdir = out_dir
)

list.files(out_dir, recursive = TRUE)

     