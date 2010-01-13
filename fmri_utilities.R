# We assume that image 1 occurs at t = 0, image 2 occurs at t = tr, and so on.
# Therefore
# (1) real.time == (image - 1) * tr
# (2) round(real.time) / tr + 1 == image
real.time.to.image.number <- function(real.time, tr = 2)
{
  return(round(real.time / tr) + 1)
}

image.number.to.real.time <- function(image.number, tr = 2)
{
  return((image.number - 1) * tr)
}

# We use Mark Cohen's gamma variate model of the HRF.
gamma.hrf <- function(t, p = 8.6, q = 0.547)
{
  return((t / (p * q))^p * exp(p - t / q))
}

hrf <- function(tr = 2, model = 'gamma')
{
  return(100 * gamma.hrf(seq(0, 14, by = tr)))
}

# 'events' must be a data frame whose rows contain events with real time
# onsets and parametric values that will be convolved with the HRF to
# generate a regressor.
build.tr.representation <- function(events, tr = 2, images = 7,
                                    onsets.key = 'onsets', values.key = 'values')
{
  tr.representation <- rep(0, images)
    
  for (index in 1:nrow(events))
  {
    real.time <- events[index, onsets.key]
    image.number <- real.time.to.image.number(real.time, tr)
    parametric.value <- events[index, values.key]
    tr.representation[image.number] <- parametric.value
  }
  
  return(tr.representation)
}

# 'events' must be a data frame whose rows contain events with real time
# onsets and parametric values that will be convolved with the HRF to
# generate a regressor.

# If you do not have a data frame in memory, pass an empty data frame in lieu 
# of 'events' and provide an explicit filename as an argument.
build.parametric.regressor <- function(events, tr = 2, images = 7,
                                       onsets.key = 'onsets', values.key = 'values',
                                       filename = NULL, separator = ',')
{
  if (! is.null(filename))
  {
    events <- read.csv(filename, header = TRUE, sep = separator)
  }
  
  tr.representation <- build.tr.representation(events, tr, images, onsets.key, values.key)
  
  return(convolve(tr.representation, rev(hrf(tr)), type = 'o')[1:images])
}
