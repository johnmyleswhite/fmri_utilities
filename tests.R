source('fmri_utilities.R')

assert <- function(obtained.value, desired.value)
{
  if (obtained.value != desired.value)
  {
    cat(paste('Got: [', obtained.value, ']\nExpected: [', desired.value, ']\n', sep = ''))
  }
}

assert.within.delta <- function(obtained.value, desired.value, delta = 0.00001)
{
  if (abs(obtained.value - desired.value) > delta)
  {
    cat(paste('Got: [', obtained.value, ']\nExpected: [', desired.value, ']\n', sep = ''))
  }
}

assert(real.time.to.image.number(0.0, tr = 2), 1)
assert(real.time.to.image.number(0.9, tr = 2), 1)
assert(real.time.to.image.number(1.9, tr = 2), 2)
assert(real.time.to.image.number(2.9, tr = 2), 2)
assert(real.time.to.image.number(2.9999999999, tr = 2), 2)
assert(real.time.to.image.number(3.0, tr = 2), 3)
assert(real.time.to.image.number(3.9, tr = 2), 3)

events <- data.frame(onsets = c(0.0, 10.0),
                     values = c(1, 5))

expected.tr.representation <- c(1, 0, 0, 0, 0, 5, 0)
assert.within.delta(build.tr.representation(events), expected.tr.representation)

expected.parametric.regressor <- c(-8.120488e-15, 8.963937e+00, 8.983442e+01, 7.584266e+01, 2.325266e+01, 4.092463e+00, 4.532671e+01)
assert.within.delta(build.parametric.regressor(events), expected.parametric.regressor)
