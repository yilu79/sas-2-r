# sas-2-r

Demo of SAS to R conversion - A collection of SAS programs converted to R with comprehensive test cases.

## Overview

This repository contains SAS programs and their R equivalents, demonstrating common data manipulation tasks in both languages. Each conversion includes:

- Original SAS code (`.sas` files)
- Converted R code (`.R` files)
- Test/demo files (`test_*.R` files)

## Contents

### 1. Create a Sorted Copy of a Table

**Files:**

- `1_Create a sorted copy of a table.sas` - Original SAS code
- `1_Create a sorted copy of a table.R` - R conversion
- `test_1_Create_a_sorted_copy_of_a_table.R` - Test cases and demo

**Description:** Demonstrates how to create a sorted copy of a dataset without modifying the original.

**Key Conversions:**

- SAS `DATA` step → R `data.frame()`
- SAS `PROC SORT` → R `dplyr::arrange()` (with base R alternative)
- SAS `PROC PRINT` → R `print()`
- SAS `BY` statement → Multiple columns in `arrange()`
- Reading external data → `read.csv()`
- Writing CSV files → `write.csv()`

## Requirements

### R Packages

The R scripts automatically check for and install required packages if missing:

```r
# Packages are auto-installed if not present
# dplyr - for data manipulation and sorting
# testthat - for unit testing

# Manual installation (if needed):
install.packages("dplyr")
install.packages("testthat")
```

## Usage

### Running the R Scripts

```r
# Run the main conversion
source("1_Create a sorted copy of a table.R")

# Run the test/demo
source("test_1_Create_a_sorted_copy_of_a_table.R")
```

### Running from Terminal

```bash
Rscript "1_Create a sorted copy of a table.R"
Rscript "test_1_Create_a_sorted_copy_of_a_table.R"
```

## Key Differences: SAS vs R

| Concept          | SAS                          | R                                     |
| ---------------- | ---------------------------- | ------------------------------------- |
| Create dataset   | `DATA` step with `datalines` | `data.frame()`                        |
| Sort data        | `PROC SORT` with `BY`        | `dplyr::arrange()` or `order()`       |
| Print output     | `PROC PRINT`                 | `print()`                             |
| Titles           | `TITLE` statement            | `cat()` or `paste()`                  |
| Package loading  | `%LET`, `LIBNAME`            | `library()`                           |
| Read CSV         | `PROC IMPORT`                | `read.csv()`                          |
| Write CSV        | `PROC EXPORT`                | `write.csv()`                         |
| Auto-install pkg | N/A                          | `require()` with `install.packages()` |

## Testing

Each R conversion includes comprehensive test cases covering:

- **Basic functionality** - Verifying core sorting operations
- **Data integrity** - Ensuring original data remains unchanged
- **Edge cases** - Testing with empty datasets and single rows
- **Alternative methods** - Comparing dplyr vs base R approaches
- **Sorting variations** - Testing ascending/descending order
- **Handling duplicates** - Verifying tie-breaking behavior

### Test Results

The test suite includes 7 comprehensive tests:

1. Basic sorting by multiple columns (Name, Subject)
2. Original data preservation verification
3. Descending order sorting
4. Base R vs dplyr method comparison
5. Duplicate value handling
6. Empty data frame edge case
7. Single row data frame edge case

## License

See LICENSE file for details.

## Contributing

Feel free to add more SAS to R conversions following the same structure:

1. Keep original SAS file
2. Create equivalent R file
3. Add comprehensive test file
4. Update this README
