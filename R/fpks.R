#' Find peaks in a trace
#'
#' @param x
#' @param nups
#' @param ndowns
#' @param zero
#' @param peakpat
#' @param minpeakheight
#' @param minpeakdistance
#' @param threshold
#' @param npeaks
#' @param sortstr
#'
#' @return
#' @export
#'
#' @examples
fpks = function (x, nups = 1, ndowns = nups, zero = "0", peakpat = NULL,
          minpeakheight = -Inf, minpeakdistance = 1, threshold = 0,
          npeaks = 0, sortstr = FALSE)
{
  stopifnot(is.vector(x, mode = "numeric") || length(is.na(x)) ==
              0)
  if (!zero %in% c("0", "+", "-"))
    stop("Argument 'zero' can only be '0', '+', or '-'.")
  xc <- paste(as.character(sign(diff(x))), collapse = "")
  xc <- gsub("1", "+", gsub("-1", "-", xc))
  if (zero != "0")
    xc <- gsub("0", zero, xc)
  if (is.null(peakpat)) {
    peakpat <- sprintf("[+]{%d,}[-]{%d,}", nups, ndowns)
  }
  rc <- gregexpr(peakpat, xc)[[1]]
  if (rc[1] < 0)
    return(NULL)
  x1 <- rc
  x2 <- rc + attr(rc, "match.length")
  attributes(x1) <- NULL
  attributes(x2) <- NULL
  n <- length(x1)
  xv <- xp <- numeric(n)
  for (i in 1:n) {
    xp[i] <- which.max(x[x1[i]:x2[i]]) + x1[i] - 1
    xv[i] <- x[xp[i]]
  }
  inds <- which(xv >= minpeakheight & xv - pmax(x[x1], x[x2]) >=
                  threshold)
  X <- cbind(xv[inds], xp[inds], x1[inds], x2[inds])
  if (minpeakdistance < 1)
    warning("Handling 'minpeakdistance < 1' is logically not possible.")
  if (sortstr && minpeakdistance > 1) {
    sl <- sort.list(X[, 1], na.last = NA, decreasing = TRUE)
    X <- X[sl, , drop = FALSE]
  }
  if (length(X) == 0)
    return(c())
  if (minpeakdistance > 1) {
    no_peaks <- nrow(X)
    badpeaks <- rep(FALSE, no_peaks)
    for (i in 1:no_peaks) {
      ipos <- X[i, 2]
      if (!badpeaks[i]) {
        dpos <- abs(ipos - X[, 2])
        badpeaks <- badpeaks | (dpos > 0 & dpos < minpeakdistance)
      }
    }
    X <- X[!badpeaks, , drop = FALSE]
  }
  if (npeaks > 0 && npeaks < nrow(X)) {
    X <- X[1:npeaks, , drop = FALSE]
  }
  return(X)
}
