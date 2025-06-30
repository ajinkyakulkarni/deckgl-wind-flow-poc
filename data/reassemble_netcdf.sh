#!/bin/bash

# Script to reassemble the split NetCDF file

echo "Reassembling NetCDF file..."

# Check if all parts exist
if [ ! -f "pres_prediction.nc.part.aa" ] || [ ! -f "pres_prediction.nc.part.ab" ] || [ ! -f "pres_prediction.nc.part.ac" ]; then
    echo "Error: Missing file parts. Please ensure all parts (aa, ab, ac) are present."
    exit 1
fi

# Reassemble the file
cat pres_prediction.nc.part.* > pres_prediction_init_2020-01-01T00_00_00_prediction_2020-01-01T06_00_00.nc

# Verify the file was created
if [ -f "pres_prediction_init_2020-01-01T00_00_00_prediction_2020-01-01T06_00_00.nc" ]; then
    echo "Successfully reassembled: pres_prediction_init_2020-01-01T00_00_00_prediction_2020-01-01T06_00_00.nc"
    echo "File size: $(ls -lh pres_prediction_init_2020-01-01T00_00_00_prediction_2020-01-01T06_00_00.nc | awk '{print $5}')"
else
    echo "Error: Failed to create reassembled file"
    exit 1
fi