context('test offense')
library(fbicrime)

df_national <- count_offense(offense = 'burglary')
df_nonnational <- count_offense(offense = 'property-crime', level = 'regions', level_detail = 'South')

test_that('data dimensions correct', {
  expect_equal(ncol(df_national), 5)
  expect_equal(ncol(df_nonnational), 6)
})

test_that('no missing values', {
  expect_identical(df_national, na.omit(df_national))
  expect_identical(df_nonnational, na.omit(df_nonnational))
})

test_that('data types correct', {
  expect_is(df_national,'data.frame')
  expect_is(df_nonnational,'data.frame')
})

