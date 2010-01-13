source('fmri_utilities.R')

events <- data.frame(onsets = c(0.0, 10.0, 25.0),
                     values = c(2, 3, 4))

power.events <- events
power.events$values <- power.events^1.01

log.events <- events
log.events$values <- log(log.events$values)

sqrt.events <- events
sqrt.events$values <- sqrt(sqrt.events$values)

plot(1:100,
     build.parametric.regressor(power.events, images = 100),
     main = 'Expected Hemodynamic Response',
     xlab = 'Time (s)',
     ylab = 'Arbitrary Units',
     type = 'l',
     col = 'purple')

points(1:100,
     build.parametric.regressor(events, images = 100),
     type = 'l',
     col = 'red')

points(1:100,
     build.parametric.regressor(log.events, images = 100),
     type = 'l',
     col = 'blue')

points(1:100,
    build.parametric.regressor(sqrt.events, images = 100),
    type = 'l',
    col = 'green')
