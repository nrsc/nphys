stimON <- function(x){
  #x = df$AD0
  x = ad
  t = x[grep("Time", names(x))]
  x = cbind.data.frame(Time = t, x[,-1]/max(x[, -1]))
  x0 <- rowMeans(x[-grep("Time", names(x))])
  C <- which(outliers::scores(x0, prob = 0.9) == TRUE)
  C0 <- data.frame(Time = x[C,1], x[C,-1])


factoextra::fviz_nbclust(C0[,1:2], kmeans, method = "silhouett")


tst <- NbClust::NbClust(C0[,1:2], method = "ward.D", index = "marriot")
max(tst$Best.nc)




# t = x[grep("Time", names(x))]
# max(x)
# x0 <- which(x[-1] > max(x[-1])/10)
# x1 = cbind.data.frame(x[x0,1], x[x0,-1]/max(x[,-1]))
#
# #x0 <- rowMeans(x[-grep("Time", names(x))])
# #C0 <- data.frame(Time = x[C,1], x[C,-1])
#
#
# #factoextra::fviz_nbclust(C0, kmeans, method = "silhouett")

}
