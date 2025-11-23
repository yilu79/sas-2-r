################################################################################
# CREATE A SORTED COPY OF A TABLE
#
# This program creates a sorted copy of the classtest table.
# Keywords: sorting, arrange, dplyr
# R Version: R 4.0+
# 
# Steps:
# 1. Create the classtest data frame and print it.
# 2. Read the classtest data frame, sort rows by ascending Name, and then 
#    Subject within each Name. The sorted data is saved in a new data frame 
#    classtest_sort. Note that if you don't create a new object, the original 
#    data frame is overwritten with a sorted version.
# 3. Print the sorted classtest_sort data frame to view it.
################################################################################

# Install and load required packages
if (!require("dplyr", quietly = TRUE)) {
  install.packages("dplyr", repos = "https://cloud.r-project.org")
  library(dplyr)
}

# 1. Create the classtest data frame
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

cat("CLASSTEST table before sorting\n")
print(classtest)
cat("\n")

# 2. Sort the data by Name and Subject (both ascending)
classtest_sort <- classtest %>%
  arrange(Name, Subject)

# Alternative base R approach without dplyr:
# classtest_sort <- classtest[order(classtest$Name, classtest$Subject), ]

# 3. Print the sorted table
cat("CLASSTEST_SORT table sorted by ascending Name and Subject\n")
print(classtest_sort)
cat("\n")
