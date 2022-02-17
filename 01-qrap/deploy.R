library(rsconnect)

deploy_xaringan <- function(doc, app_title){
  qualified_doc <- normalizePath(doc, winslash = "/")
  app_files <-  c(
    basename(qualified_doc),
    list.files("img", pattern = ".*.png", full.names = TRUE, recursive = TRUE),
    list.files("img", pattern = ".*.jpg", full.names = TRUE, recursive = TRUE),
    list.files("img", pattern = ".*.gif", full.names = TRUE, recursive = TRUE),
    list.files("include", pattern = ".*.png", full.names = TRUE, recursive = TRUE),
    list.files("include", pattern = ".*.jpg", full.names = TRUE, recursive = TRUE),
    list.files("theme", pattern = "*.png", full.names = TRUE, recursive = TRUE),
    list.files("libs", full.names = TRUE, recursive = TRUE)
  )
  res_files <- rmarkdown::find_external_resources(qualified_doc)
  app_files <- c(app_files, res_files$path)
  rsconnect::deployApp(
    appDir = dirname(qualified_doc),
    appPrimaryDoc = basename(qualified_doc),
    appTitle = app_title,
    appFiles = app_files,
    forceUpdate = TRUE,
    server = "q-rap.qub.ac.uk"
  )
}

deploy_xaringan(doc = "cloud_teaching.html",
                app_title = "cloud-teaching")



