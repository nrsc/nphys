sort_rdaDATA <- function(x, amp = "p"){
if(amp == "a"|amp =="p"){
ampA <- lapply(x, function(x){
  df <- x[grep(pattern = ("Imon1|Vmon1|AD0"), names(x))]
  })
names(ampA) <- gsub("^.", "a", names(ampA))
}
if(amp == "a")return(list(ampA = ampA))

if (amp == "b"|amp =="p"){
ampB <- lapply(x, function(x){
  df <- x[grep(pattern = ("Imon2|Vmon2|AD0"), names(x))]
  })
names(ampB) <- gsub("^.", "b", names(ampB))
}
if(amp == "b")return(list(ampB = ampB))

if(amp == "p")return(list(ampA = ampA, ampB = ampB))

}

