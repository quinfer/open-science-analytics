library(rsconnect)
folder="01-cloud"
docname="cloud_teaching.html"
files_paths<-c("img","libs","include","theme")
paths<-paste0(folder,"/",c(docname,files_paths))
qualified_paths<-vector("character",length=length(paths))
for (i in seq_along(paths)) {
  print(paths[i])
  qualified_paths[i]<-normalizePath(paths[i],winslash = "/")
}
qp<-qualified_paths[str_detect(qualified_paths,"home")]

app_files <-  c(
  basename(qp[1]),
  list.files(qp[2], pattern = ".*.png", full.names = TRUE, recursive = TRUE),
  list.files(qp[2], pattern = ".*.jpg", full.names = TRUE, recursive = TRUE),
  list.files(qp[2], pattern = ".*.gif", full.names = TRUE, recursive = TRUE),
  # list.files(include_path, pattern = ".*.png", full.names = TRUE, recursive = TRUE),
  # list.files(include_path, pattern = ".*.jpg", full.names = TRUE, recursive = TRUE),
  # list.files(theme_path, pattern = "*.png", full.names = TRUE, recursive = TRUE),
  list.files(qp[3], full.names = TRUE, recursive = TRUE)
)

res_files <- rmarkdown::find_external_resources(qp[1])
app_files <- c(app_files, res_files$path)
app_title="cloud-teaching"
rsconnect::deployApp(
  appDir = dirname(qualified_doc),
  appPrimaryDoc = basename(qualified_doc),
  appTitle = app_title,
  appFiles = app_files,
  forceUpdate = TRUE,
  server = "q-rap.qub.ac.uk")


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



