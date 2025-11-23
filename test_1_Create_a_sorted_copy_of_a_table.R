################################################################################
# TEST CASE / DEMO FOR: Create a sorted copy of a table
#
# This script demonstrates and tests the sorting functionality
# with various test cases to verify correct behavior
################################################################################

# Install and load required packages
if (!require("dplyr", quietly = TRUE)) {
  install.packages("dplyr", repos = "https://cloud.r-project.org")
  library(dplyr)
}

if (!require("testthat", quietly = TRUE)) {
  install.packages("testthat", repos = "https://cloud.r-project.org")
  library(testthat)
}

cat("========================================\n")
cat("DEMO: Create a Sorted Copy of a Table\n")
cat("========================================\n\n")

# Source the original script (or replicate the logic here for testing)
# For this demo, we'll replicate the logic

# Create the original classtest data frame
classtest <- data.frame(
  Name = c("Judy", "Judy", "Barbara", "Barbara", "Barbara", 
           "Louise", "Louise", "William", "William", "Henry", 
           "Henry", "Henry", "Jane", "Jane"),
  Subject = c("Reading", "Math", "Math", "Reading", "Math", 
              "Math", "Reading", "Math", "Reading", "Math", 
              "Reading", "Reading", "Math", "Reading"),
  Score = c(91, 79, 90, 86, 90, 72, 65, 61, 71, 62, 75, 84, 94, 96),
  stringsAsFactors = FALSE
)

cat("TEST 1: Basic Sorting by Name and Subject\n")
cat("------------------------------------------\n")
classtest_sort <- classtest %>%
  arrange(Name, Subject)

cat("Original row order (first 5 rows):\n")
print(head(classtest, 5))

cat("\nSorted row order (first 5 rows):\n")
print(head(classtest_sort, 5))

# Verify the sort order
test_that("Data is sorted by Name then Subject", {
  # Check that Name is in ascending order
  expect_true(all(diff(as.numeric(factor(classtest_sort$Name))) >= 0))
  
  # Check first name is Barbara
  expect_equal(classtest_sort$Name[1], "Barbara")
  
  # Check that Barbara's subjects are in order (Math before Reading)
  barbara_rows <- classtest_sort[classtest_sort$Name == "Barbara", ]
  expect_equal(barbara_rows$Subject, c("Math", "Math", "Reading"))
})

cat("\n✓ Test 1 passed: Basic sorting works correctly\n\n")


cat("TEST 2: Verify Original Data Unchanged\n")
cat("---------------------------------------\n")
test_that("Original data frame is not modified", {
  # Recreate original to compare
  classtest_original <- data.frame(
    Name = c("Judy", "Judy", "Barbara", "Barbara", "Barbara", 
             "Louise", "Louise", "William", "William", "Henry", 
             "Henry", "Henry", "Jane", "Jane"),
    Subject = c("Reading", "Math", "Math", "Reading", "Math", 
                "Math", "Reading", "Math", "Reading", "Math", 
                "Reading", "Reading", "Math", "Reading"),
    Score = c(91, 79, 90, 86, 90, 72, 65, 61, 71, 62, 75, 84, 94, 96),
    stringsAsFactors = FALSE
  )
  
  expect_equal(classtest, classtest_original)
  expect_false(identical(classtest, classtest_sort))
})

cat("✓ Test 2 passed: Original data remains unchanged\n\n")


cat("TEST 3: Sorting with Descending Order\n")
cat("--------------------------------------\n")
classtest_desc <- classtest %>%
  arrange(desc(Name), desc(Subject))

cat("First 3 rows sorted descending:\n")
print(head(classtest_desc, 3))

test_that("Descending sort works correctly", {
  expect_equal(classtest_desc$Name[1], "William")
  expect_equal(classtest_desc$Subject[1], "Reading")
})

cat("✓ Test 3 passed: Descending sort works correctly\n\n")


cat("TEST 4: Base R Alternative Method\n")
cat("----------------------------------\n")
classtest_base <- classtest[order(classtest$Name, classtest$Subject), ]

test_that("Base R method produces same result as dplyr", {
  # Reset row names for comparison
  rownames(classtest_sort) <- NULL
  rownames(classtest_base) <- NULL
  
  expect_equal(classtest_base, classtest_sort)
})

cat("✓ Test 4 passed: Base R method matches dplyr result\n\n")


cat("TEST 5: Sorting with Ties (Multiple Same Values)\n")
cat("-------------------------------------------------\n")
# Barbara has two rows with Math and score 90
barbara_math <- classtest_sort %>%
  filter(Name == "Barbara", Subject == "Math")

cat("Barbara's Math scores:\n")
print(barbara_math)

test_that("Ties are preserved", {
  expect_equal(nrow(barbara_math), 2)
  expect_true(all(barbara_math$Score == 90))
})

cat("✓ Test 5 passed: Duplicate values handled correctly\n\n")


cat("TEST 6: Edge Case - Empty Data Frame\n")
cat("-------------------------------------\n")
empty_df <- data.frame(
  Name = character(0),
  Subject = character(0),
  Score = numeric(0)
)

empty_sorted <- empty_df %>%
  arrange(Name, Subject)

test_that("Empty data frame can be sorted", {
  expect_equal(nrow(empty_sorted), 0)
  expect_equal(ncol(empty_sorted), 3)
})

cat("✓ Test 6 passed: Empty data frame handled correctly\n\n")


cat("TEST 7: Single Row Data Frame\n")
cat("------------------------------\n")
single_row <- data.frame(
  Name = "Alice",
  Subject = "Science",
  Score = 95,
  stringsAsFactors = FALSE
)

single_sorted <- single_row %>%
  arrange(Name, Subject)

test_that("Single row data frame remains unchanged", {
  expect_equal(single_sorted, single_row)
})

cat("✓ Test 7 passed: Single row handled correctly\n\n")

cat("========================================\n")
cat("ALL TESTS PASSED!\n")
cat("========================================\n\n")

cat("SUMMARY OF RESULTS:\n")
cat("-------------------\n")
cat("Total rows in original data:", nrow(classtest), "\n")
cat("Total rows in sorted data:", nrow(classtest_sort), "\n")
cat("Unique names:", length(unique(classtest$Name)), "\n")
cat("Unique subjects:", length(unique(classtest$Subject)), "\n\n")

cat("Final sorted table by Name and Subject:\n")
print(classtest_sort)
