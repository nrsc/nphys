ksmoothVec <- function(x, bw = 50){
    y = x
    x = zoo::index(x)
    krnl = ksmooth(x, y, kernel = "box", bandwidth = bw)
    all.equal(krnl$x, x)
    return(krnl)
}
