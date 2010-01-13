source('fmri_utilities.R')

regressor <- build.parametric.regressor(NULL,
                                        tr = 2,
                                        images = 60,
                                        onsets.key = 'Stimulus.Onset',
                                        values.key = 'Stimulus.Intensity',
                                        filename = 'example_data.csv',
                                        separator = ',')

write.table(regressor,
            file = 'example_output.1D',
            sep = ' ',
            row.names = FALSE,
            col.names = FALSE)
