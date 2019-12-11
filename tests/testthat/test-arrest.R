context('test arrest')
library(fbicrime)

df_national <- summarize_arrest(by_offense_type = TRUE, offense = c('aggravated-assault','rape'), variable = 'race', since = 2010, until = 2011)

test_that('data dimensions correct', {
  expect_equal(ncol(df_national), 5)
})

test_that('no missing values', {
  expect_identical(df_national, na.omit(df_national))
})

test_that('data types correct', {
  expect_is(df_national,'data.frame')
})
