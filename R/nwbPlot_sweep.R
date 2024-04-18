#' Title
#'
#' @param x
#'
#' @return
#'
#' @examples
#' h = hct
#'
#'
#'
#' @export
nwbPlot_sweep = function(x, acquisition_name, stimulus_name, show_stimulus = TRUE, return_plot = FALSE, scaleBar = TRUE, show_plot = TRUE){

  if(missing(stimulus_name)){
    stimulus_name = acquisition_name
  }
  #exp = projHCT::extractNWB(x, sweeps = acquisition_name, stimulus_sweeps = stimulus_name, epoch = FALSE)
  #sweep = exp$

  sweep = nphys::extractNWB(x, sweeps = acquisition_name, slim = TRUE)

  if(!show_stimulus){
    df = data.frame(sweep, zoo::index(sweep))
        names(df) = c("y","x")


        gg = ggplot2::ggplot(df, aes(x, y)) +
            ggplot2::geom_line() +
            ggplot2::theme_void()
  }

  if(show_stimulus){
  stim = projHCT::extractNWB(x, stimulus_sweeps = stimulus_name, slim = TRUE)
  exp = projHCT::extractNWB(x, epoch = FALSE)
  rate = as.numeric(exp$sampling_rate[grep(acquisition_name, names(exp$sampling_rate))])
  df = data.frame(sweep, stim, x = nphys::convertIndex(sweep, rate))
  names(df) = c("y", "s", "x")

  ### Sweep Void Plot
  gg2 = ggplot(df, aes(x, y)) +
    geom_line() +
    theme_void() +
    theme(panel.background = element_rect(fill = 'white', colour = 'white'))

  ggStim = ggplot(df, aes(x, s)) +
    geom_line() +
    theme_void() +
    theme(panel.background = element_rect(fill = 'white', colour = 'white'))



  if (scaleBar) {
    ymn = min(sweep, na.rm = TRUE) - 2
    xv = -.5

    gg2 = gg2 + geom_segment(aes(
      x = xv,
      xend = xv,
      y = ymn + 9.5,
      yend = ymn - .5
    )) +
      geom_segment(aes(
        x = xv,
        xend = xv + 1,
        y = ymn - 0.5,
        yend = ymn - 0.5
      ))
    ggStim = ggStim + geom_segment(aes(
      x = xv,
      xend = xv,
      y = 0,
      yend = 100
    ))

  }

  gg = gridExtra::arrangeGrob(gg2, ggStim, layout_matrix = rbind(1, 1, 1, 1, 1, 1, 1, 1, 1, 2))

  }

  if(show_plot){
    grid::grid.newpage()
    grid::grid.draw(gg)
  }

  if(return_plot){
    return(gg)
  }

}
