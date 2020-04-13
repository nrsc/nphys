#' Title
#'
#' @param x
#'
#' @return dfCross
#' @export Cross0
#'
Cross0 <- function(x){


    df = x

    mVmax <- df[which.min(df$Data),]
    #ymax <- df[which.max(df$Slope),"Slope"]
    #ymin <- df[which.min(df$Data),"Data"]

    r <- which.min(df$Data)
    df <- df[1:(r-50),]


    {
            zc_down <- df[-1,2] < 0 & df[-nrow(df),2] >= 0
            zc_up <- df[-1,2] >= 0 & df[-nrow(df),2] < 0

            X_down = which(zc_down)
            X_up = which(zc_up)

            dn <- df[c(X_down), ]
            up <- df[c(X_up), ]

        }


    if (nrow(dn) > 1){

        dn <- dn[nrow(dn),]

    }
    if (nrow(up) > 1){

        up <- up[1,]
    }



    dfCross <- rbind.data.frame(up = up, down = dn, mVmax = mVmax)

    #plot(df$Time,df$Slope,type='b', ylim = c(ymin, ymax))
    #    points(df$Time, df$Data, type = 'b', col = "blue")
    #    points(dn$Time, dn$Slope, col="red",pch='v', cex = 3)
    #    points(up$Time, up$Slope, col="orange",pch='^', cex = 3)

    return(dfCross)




}
