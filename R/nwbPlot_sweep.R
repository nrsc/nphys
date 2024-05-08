#' Plot a sweep from the nwb file path
#'
#' @param x nwb file path
#' @param acquisition_name character string or numeric
#' @param stimulus_name character
#' @param ds_int
#' @param return_plot
#' @param scaleBar
#' @param show_plot
#' @param sweepColour
#' @param return_df
#'
#' @return
#'
#' @examples
#' x = "/home/nrsc/nphys/exd/nwb/NWBv2.nwb"
#'
#'
#'
#' @export
nwbPlot_sweep = function(x,
                         acquisition_name,
                         stimulus_name = FALSE,
                         ds_int = NULL,
                         return_plot = FALSE,
                         scaleBar = TRUE,
                         show_plot = TRUE,
                         sweepColour = "black",
                         return_df = FALSE) {
    if (missing(stimulus_name)) {
        stimulus_name = acquisition_name
    }
    # if(acquisition_name != stimulus_name){
    #
    # }

    ## Build in test for this ##
    dfs = nphys::extractNWB(x,
                            sweeps = acquisition_name,
                            slim = FALSE,
                            stimulus_sweeps = stimulus_name)
    rate = as.numeric(dfs$sampling_rate[acquisition_name])
    sweep = dfs$sweeps
    stim = dfs$stimulus_sweeps
    ## ##
    df = data.frame(sweep, stim, x = nphys::convertIndex(sweep, rate))
    names(df) = c("y", "s", "x")

    if (return_df) {
        return(df)
    }

    ### Sweep Void Plot
    ggSweep = ggplot2::ggplot(df, aes(x, y)) +
        ggplot2::geom_line(colour = sweepColour) +
        ggplot2::theme_void()

    ggStim = ggplot2::ggplot(df, aes(x, s)) +
        ggplot2::geom_line(colour = sweepColour) +
        ggplot2::theme_void()


    if (scaleBar) {
        ymn = min(sweep, na.rm = TRUE) - 2
        xv = -.5

        # yV = scaleBar
        # yendV

        ## Add
        ggSweep = ggSweep + annotate(
            geom = "segment",
            x = xv,
            xend = xv,
            y = ymn + 9.5,
            yend = ymn - .5
        ) +
            annotate(
                geom = "segment",
                x = xv,
                xend = xv + 1,
                y = ymn - 0.5,
                yend = ymn - 0.5
            )

        ## add pA to scaleBar
        ggStim = ggStim + annotate(
            geom = "segment",
            x = xv,
            xend = xv,
            y = 0,
            yend = 100
        )

    }

    # if(is.numeric(ds_int)){
    #   if(show_plot){
    #    plot(gg2)
    #   }
    #
    #   if(return_plot){
    #     return(gg2)
    #   }
    #   }


    ggSweep = gridExtra::arrangeGrob(ggSweep, ggStim, layout_matrix = rbind(1, 1, 1, 1, 1, 1, 1, 1, 1, 2))


    if (show_plot) {
        grid::grid.newpage()
        grid::grid.draw(ggSweep)
    }

    if (return_plot) {
        return(ggSweep)
    }

    if (return_df) {
        return(df)
    }

}
