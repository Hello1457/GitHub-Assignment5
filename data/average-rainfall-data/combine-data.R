melb_df <- read.table(
  file = "melbourne.csv",
  header = TRUE,
  sep = ",",
  skip = 11)

mean_rainfall_melb <- as.numeric(melb_df[24,2:13])

ox_df <- read.table(
  file = "oxford.txt",
  header = FALSE,
  col.names = c("year", "month", "x1", "x2", "x3", "rain", "x4"),
  skip = 7,
  na.strings = "---",
  nrows = 12 * (2020 - 1853))

year_mask <- (1855 <= ox_df$year) & (ox_df$year <= 2015)
tmp <- ox_df[year_mask,c("month","rain")]
tmp$rain <- as.numeric(
  gsub(
    pattern = "\\*",
    replacement = "",
    x = tmp$rain))

mean_rainfall_ox <- aggregate(
  x = tmp,
  by = list(month = tmp$month),
  FUN = mean)$rain

months <- c(
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December")

plot_df <- data.frame(
  month = rep(months, 2),
  month_num = rep(1:12, 2),
  location = rep(c("Melbourne", "Oxford"), each = 12),
  average_rainfall = c(mean_rainfall_melb, mean_rainfall_ox))

write.table(x = plot_df,
            file = "data/average-rainfall-data/average-rainfall.csv",
            sep = ",",
            row.names = FALSE)
            
# Session Information

R version 4.0.3 (2020-10-10)
Platform: x86_64-apple-darwin17.0 (64-bit)
Running under: macOS Big Sur 10.16

Matrix products: default
LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib

locale:
[1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] dplyr_1.0.7          janitor_2.1.0        palmerpenguins_0.1.0
[4] ggpubr_0.4.0         ggplot2_3.3.5       

loaded via a namespace (and not attached):
 [1] tidyselect_1.1.1  xfun_0.26         purrr_0.3.4       splines_4.0.3    
 [5] lattice_0.20-41   carData_3.0-4     snakecase_0.11.0  colorspace_2.0-0 
 [9] vctrs_0.3.8       generics_0.1.0    htmltools_0.5.1.1 yaml_2.2.1       
[13] mgcv_1.8-33       utf8_1.1.4        rlang_0.4.11      pillar_1.6.3     
[17] glue_1.4.2        withr_2.4.1       DBI_1.1.1         dbplyr_2.1.1     
[21] lifecycle_1.0.1   stringr_1.4.0     munsell_0.5.0     ggsignif_0.6.3   
[25] gtable_0.3.0      evaluate_0.14     labeling_0.4.2    knitr_1.33       
[29] fansi_0.4.2       broom_0.7.9       scales_1.1.1      backports_1.2.1  
[33] abind_1.4-5       farver_2.0.3      digest_0.6.27     stringi_1.5.3    
[37] rstatix_0.7.0     grid_4.0.3        cli_3.0.1         tools_4.0.3      
[41] magrittr_2.0.1    tibble_3.1.5      crayon_1.4.1      tidyr_1.1.4      
[45] car_3.0-12        pkgconfig_2.0.3   ellipsis_0.3.2    Matrix_1.2-18    
[49] lubridate_1.8.0   assertthat_0.2.1  rmarkdown_2.11    rstudioapi_0.13  
[53] R6_2.5.0          nlme_3.1-149      compiler_4.0.3   
