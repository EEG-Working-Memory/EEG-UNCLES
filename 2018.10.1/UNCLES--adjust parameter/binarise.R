######################################################################
#å½æ°å?:binarise
#å½æ°åè½:äºå¼åæä½
#åæ°:
#   Uï¼ä¼ å¥è¦è¿è¡æä½çç©é?/åé
#   Kï¼è¦åçç±»çæ°ç®
#   techniqueï¼äºå¼åæä½çå ä¸ªéæ©:ï¼ä¸ä¸çå ç§äºå¼åæ¹æ³ï¼åè¶å­¦é¿å·²ç»ç»åºå·ä½çå¬å¼ï¼ä¸è¿çä»£ç ä¹è½çåºæ¥ï¼
#               1 UB/union binarization(default)
#               2 IB/intersection binarization
#               3 MVB/maximum value Binarization  
#               4 VTB/value thresholding binarization
#               5 std thresh??? (TB/top binarization?)
#               6 DTB/difference Thresholding binarization
#   parameter: éå¼ï¼äºå¼åçéå?
#è¿åå?:    
#   ä¸ä¸ªboolç±»åçï¼ç»´åº¦åè¾å¥çUç¸åçåé?
#ç¼åèï¼å®å®å?
#æ¶é´ï¼?2018/5/5
########################################################################
binarise <- function(U, K, technique = "DTB", parameter = 0.5) {
    technique = tolower(technique)
    if (technique == "union" || technique == "ub") {
        return(U > 0)
    } else if (technique == "intersection" || technique == "ib") {
        return(U == 1)
    } else if (technique == "max" || technique == "mvb") {
        return(U == matrix(1, K, 1) %*% apply(U, 2, max))
    } else if (technique == "valuethresh" || technique == "value" || technique == "vtb") {
        return(U >= parameter)
    } else if (technique == "stdthresh" || technique == "std") {
        return((matrix(1, K, 1) %*% apply(U, 2, sd) >= parameter) & (U == matrix(1, K, 1) %*% apply(U, 2, max)))
    } else if (technique == "difference" || technique == "dtb") {
        if (is.vector(U) || nrow(U) == 1) {
            diff = rep(1, length(U))
        } else {
            Us = apply(U, 2, sort)
            diff = Us[nrow(Us),] - Us[nrow(Us) - 1,]
        }
        return(((matrix(1, K, 1) %*% diff) >= parameter) & (U == matrix(1, K, 1) %*% apply(U, 2, max)))
    } else if (technique == "top" || technique == "tb") {
        return(U >= (matrix(1, K, 1) %*% apply(U, 2, max) - parameter))
    } else {
        stop("Unknown binarisation technique")
    }
}
