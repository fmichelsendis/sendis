context("Sendis data expected dimensions")

test_that("sendis data frame has expected content",
          {
            expect_equal(dim(sendis)[1], 13278)
            expect_equal(dim(sendis)[2], 24)
            }
          )
