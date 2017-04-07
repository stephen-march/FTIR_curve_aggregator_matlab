# FTIR_curve_aggregator

FTIR curve aggregator looks for .dpt files produced by Bruker's OPUS software and merges all the files into a single output .csv file. It is designed for files saved with common x-axis values in wavenumbers (cm^-1).

Future functionality will include saving the output files with both their wavenumber (cm^-1) and wavelength (um) values regardless of what the input file provided.

This software was written in MATLAB using the 2014A distribution.

Run using organize_data.m

Dependencies that must be in the same directory as organize_data.m:
getdata.m
linecount.m
data_aggregate.m

B150903 and B160216 are sample files that will be merged into a single output file. Unless the directory path is changed within organize_data.m, these sample input files need reside within the same directory as the remaining scripts.
