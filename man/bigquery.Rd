% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dbi-driver.R
\name{bigquery}
\alias{bigquery}
\alias{dbi_driver}
\alias{dbConnect,BigQueryDriver-method}
\title{BigQuery DBI driver}
\usage{
\S4method{dbConnect}{BigQueryDriver}(
  drv,
  project,
  dataset = NULL,
  billing = project,
  page_size = 10000,
  quiet = NA,
  use_legacy_sql = FALSE,
  bigint = c("integer", "integer64", "numeric", "character"),
  ...
)
}
\arguments{
\item{drv}{an object that inherits from \linkS4class{DBIDriver},
or an existing \linkS4class{DBIConnection}
object (in order to clone an existing connection).}

\item{project, dataset}{Project and dataset identifiers}

\item{billing}{Identifier of project to bill.}

\item{page_size}{Number of items per page.}

\item{quiet}{If \code{FALSE}, displays progress bar; if \code{TRUE} is silent;
if \code{NA} displays progress bar only for long-running jobs.}

\item{use_legacy_sql}{If \code{TRUE} will use BigQuery's legacy SQL format.}

\item{bigint}{The R type that BigQuery's 64-bit integer types should be mapped to.
The default is \code{"integer"} which returns R's \code{integer} type but results in \code{NA} for
values above/below +/- 2147483647. \code{"integer64"} returns a \link[bit64:bit64-package]{bit64::integer64},
which allows the full range of 64 bit integers.}

\item{...}{Other arguments for compatibility with generic; currently ignored.}
}
\description{
Creates a BigQuery DBI driver for use in \code{\link[DBI:dbConnect]{DBI::dbConnect()}}.
}
\examples{
if (bq_testable()) {
con <- DBI::dbConnect(
  bigquery(),
  project = "publicdata",
  dataset = "samples",
  billing = bq_test_project()
)
con
DBI::dbListTables(con)
DBI::dbReadTable(con, "natality", n_max = 10)

# Create a temporary dataset to explore
ds <- bq_test_dataset()
con <- DBI::dbConnect(
  bigquery(),
  project = ds$project,
  dataset = ds$dataset
)
DBI::dbWriteTable(con, "mtcars", mtcars)
DBI::dbReadTable(con, "mtcars")[1:6, ]

DBI::dbGetQuery(con, "SELECT count(*) FROM mtcars")

res <- DBI::dbSendQuery(con, "SELECT cyl, mpg FROM mtcars")
dbColumnInfo(res)
dbFetch(res, 10)
dbFetch(res, -1)
DBI::dbHasCompleted(res)

}
}
