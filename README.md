# Wind Vector Visualization with deck.gl

This project provides an interactive visualization of global wind patterns using deck.gl, a WebGL-powered framework for visual exploratory data analysis of large datasets.

![Wind Flow Visualization](screenshot.gif)

## Overview

The visualization shows wind flow as animated particles that move according to wind vector data, creating continuous streams that reveal atmospheric circulation patterns.

## Features

- **Particle-based animation**: Thousands of particles flow according to wind vectors
- **Smooth trails**: Particles leave fading trails showing wind paths
- **Real data support**: Loads wind data from CSV files with U/V components
- **Performance optimized**: Spatial indexing for fast interpolation with large datasets
- **Interactive controls**: Adjust particle count, animation speed, and trail persistence
- **Automatic data sampling**: Handles large datasets by intelligent sampling
- **Progress indicator**: Shows loading status for large data files

## Data Format

The visualizations expect wind data in CSV format with the following columns:
```csv
index,lev,lat,lon,U,V
0,72.0,-90.0,-180.0,3.6570468,3.6269567
1,72.0,-90.0,-179.37391,3.6335552,4.035838
...
```

- `lat`: Latitude (-90 to 90)
- `lon`: Longitude (-180 to 180)
- `U`: East-west wind component (m/s)
- `V`: North-south wind component (m/s)

## Setup Instructions

### 1. File Structure
Place your files in a directory:
```
deckgl-model-data-animation/
├── index.html
├── uv.csv (your wind data)
└── README.md
```

### 2. Prepare Wind Data
- Name your wind data file `uv.csv`
- Ensure it follows the format described above
- Large datasets (>100k points) will be automatically sampled for performance

#### Note on Large NetCDF File
The repository includes a split NetCDF file for file size constraints:
- `pres_prediction.nc.part.aa`, `.ab`, `.ac` - Split parts of the original NetCDF file
- Run `./reassemble_netcdf.sh` to reconstruct the original file
- The reassembled file will be ignored by git (see .gitignore)

### 3. Start Local Server
Due to browser security restrictions, you need to serve the files through a local web server:

```bash
# Navigate to the project directory
cd /path/to/deckgl-model-data-animation

# Start a simple HTTP server (Python 3)
python3 -m http.server 8888

# Or using Python 2
python -m SimpleHTTPServer 8888

# Or using Node.js
npx http-server -p 8888
```

### 4. Open in Browser
Navigate to: `http://localhost:8888/`

The visualization will automatically load the `uv.csv` file and begin animating.

## Understanding the Visualization

### What the Particles Represent
- Each particle acts as a **tracer** showing how air flows
- Particles follow wind vectors (U,V components) from your data
- The movement visualizes wind as continuous fluid motion

### Important Note About Temporal Data
The current implementation uses **static wind data** (single timestamp):
- Particles move according to wind vectors frozen at one moment
- Shows where air parcels would travel IF wind remained constant
- Does NOT show how wind patterns change over time

#### Why This Visualization is Still Valuable
Despite using a single timestamp, this approach provides important insights:

1. **Flow Patterns** - Reveals circulation patterns, convergence zones, and wind streams that are difficult to see with static arrows
2. **Transport Pathways** - Shows potential paths for atmospheric transport (pollution, dust, moisture)
3. **Relative Speeds** - Visual comparison of wind speeds across different regions through particle density and trail length
4. **Intuitive Understanding** - Animated particles make wind fields more intuitive than traditional vector plots
5. **Educational Value** - Helps students and researchers understand atmospheric dynamics

#### For True Temporal Evolution
To show how weather systems actually evolve, you would need:
- Multiple timestamps of wind data (e.g., hourly data)
- Time interpolation between frames
- Dynamic wind field updates
- Playback controls to move forward/backward in time

### Performance Considerations

**Large Datasets**
- Datasets with >100k points are automatically sampled
- Default sampling targets ~50k points for smooth performance
- Spatial indexing enables fast nearest-neighbor lookups

**Optimization Tips**
- Reduce particle count if animation is choppy
- Adjust fade speed - higher values (0.99) create longer trails but use more memory
- Close other browser tabs for better performance

## Controls

- **Pause/Play**: Stop or resume animation
- **Particle Count**: 1,000-10,000 particles (default: 3,000)
- **Speed**: Animation speed multiplier (0.1x-3x)
- **Fade Speed**: Trail persistence (0.9-0.99) - higher values create longer trails

## Technical Details

### Technologies Used
- **deck.gl**: WebGL-powered data visualization
- **Mapbox GL JS**: Base map rendering
- **CartoDB**: Dark matter basemap tiles

### Interpolation Method
- Spatial grid index for O(1) nearest neighbor lookup
- Inverse distance weighted interpolation
- 4 nearest points used for smooth transitions

### Particle System
- Particles have limited lifetime (age out and respawn)
- Position updates based on local wind velocity
- Trail rendering using deck.gl PathLayer

## Troubleshooting

**"No animation visible"**
- Check browser console for errors
- Ensure CSV file is in correct format
- Try reducing particle count
- Verify wind data has non-zero U/V values

**"Page loads slowly"**
- Large datasets take time to process
- Progress bar shows loading status
- Consider pre-processing data to reduce size

**"Animation is choppy"**
- Reduce particle count
- Close other browser tabs
- Try Chrome/Firefox for better WebGL performance

## Browser Compatibility
- Chrome (recommended)
- Firefox
- Safari
- Edge

Requires WebGL support and modern JavaScript features.

## Future Enhancements

Potential improvements for temporal visualization:
- Load multiple timestamp data
- Animate between time steps
- Show wind evolution over time
- Add playback controls for temporal dimension

## License

This project uses open-source libraries:
- deck.gl (MIT License)
- Mapbox GL JS (BSD License)