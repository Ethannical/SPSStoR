#' Correlations to R
#' 
#' Converts SPSS correlations routine syntax to R correlation syntax
#' 
#' @param x SPSS syntax - read in by SPSStoR function
#' @export 
correlations_to_r <- function(x){
  
  varsLoc <- grep("variables\\s?=", x, ignore.case = TRUE)
  vars <- substr(x[varsLoc], (which(strsplit(x[varsLoc], '')[[1]]=='=')+1), nchar(x[varsLoc]))
  corVars <- paste(unlist(strsplit(gsub("^\\s+|\\s+$", "", vars), " ")), collapse = ", ")
  
  if(length(grep("\\/missing\\s?=\\s?pairwise", x, ignore.case = TRUE)) == 1){
    missing <- "use = pairwise.complete.obs"
  } else {
    missing <- "use = na.or.complete"
  }
    
  finMat <- matrix(nrow = 1, ncol = 1)
  finMat[1] <- paste("with(x, cor(cbind(", corVars, ")),", missing, ")", sep = "")
    
  finMat
}
