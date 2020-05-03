###

FV = Baseline$FV
EPSP = Baseline$EPSP
fv.epsp <- rbind.data.frame(FV, EPSP)# %>%

avg <- Avg_Sweeps(fv.epsp)


fit <- stats::loess(mV~ms,data = avg)
slp <- Slope.Read_0(fit$y, ms = fit$x)
fit.slp <- stats::loess(mVms~ms, data = slp)

fit2 <- lm(mV~poly(ms, 2,raw = TRUE), data = avg)



p1x <- which.max(fit$fitted)
p1y <- max(fit$fitted)
p2x <- which.min(fit$fitted)
p2y <- min(fit$fitted)

plot(x = fit$x, y = fit$y, xlab = fit$xnames, ylab = fit$terms[[2]],  type = "l")
#points(x = p1x, y = p1y, col= "red")
#points(x = p2x, y = p2y, col= "red")
lines(fit$x,fit$fitted,col = "blue")
lines(fit$x,slp$mVms,col = "green")
lines(fit$x,fit.slp$fitted, col = "red")


line(avg, predict(fit2, data.frame(x = avg)))




