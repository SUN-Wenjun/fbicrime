# fbicrime - a R wrapper for FBI Crime API 

This package is an R wrapper for the [FBI Crime API](https://crime-data-explorer.fr.cloud.gov/api), it aims to provide an easy access for R users to the most updated data about offense, offender, victim, and arrest from the API. It also makes it possible to query multiple keywords at one time and return a combined data frame. 

## How to install
```R
# install.packages("devtools")

library(devtools)
install_github("SUN-Wenjun/fbicrime")
library(fbicrime)
```

## How to use

You need to get a key for the API at https://api.data.gov/signup/

Then you can access FBI crime data by calling functions in this package. You can either input your API key each time when use functions or save it as a global variable in your R session using function `set_fbi_crime_api_key('')`.

## How to find help
[main help document](https://htmlpreview.github.io/?https://github.com/SUN-Wenjun/fbicrime/blob/master/doc/fbicrime.html)

After install and library this package, you can also access to the help document of each function by excuting
```R
?function_name
```

## [a Medium post](https://medium.com/@wenjun.sarah.sun/an-r-wrapper-for-fbi-crime-api-a80f8586e0ff?sk=598e89e2f68eea689cef9c7c92f90ce0) about this package
