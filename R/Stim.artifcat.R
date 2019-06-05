stim_Artifact <- function(x){


SA = head(which(diff(x) == sort(diff(x))[1]),1)-100

x = l[,ncol(l)]
xc <- paste(as.character(sign(diff(x))), collapse = "")
xc <- gsub("1", "+", gsub("-1", "-", xc))
nups = 2
ndowns = nups
peakpat <- sprintf("[+]{%d,}[-]{%d,}", nups, ndowns)



rc <- gregexpr(peakpat, xc)[[1]]
rc[1]


    return()
}

