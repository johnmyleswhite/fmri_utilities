First, we define two functions for converting between real time in seconds and
the index of an image defined by a TR expressed in seconds:
<pre>
real.time.to.image.number
image.number.to.real.time
</pre>

Next, we define a canonical HRF uses AFNI's version of Mark Cohen's gamma
variate model.
<pre>
gamma.hrf
hrf
</pre>

Then, we build up a representation of our experiment's events in the form
that we will convolve with our canonical HRF:
<pre>
build.tr.representation
</pre>

Finally, we convolve this with the HRF to produce a finished parametric
regressor.
<pre>
build.parametric.regressor
</pre>

For normal use you probably just want to import your experimental event data
from a CSV file into a data frame and then use `build.parametric.regressor()`
to generate the regressors for your design matrix.
