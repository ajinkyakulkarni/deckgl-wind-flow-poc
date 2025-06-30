# Wind Vector Visualization with deck.gl

This project provides interactive visualizations of global wind patterns using deck.gl, a WebGL-powered framework for visual exploratory data analysis of large datasets.

## Overview

Two visualization modes are available:

1. **Wind Flow Visualization** (`wind-flow-visualization.html`) - Particle flow animation showing wind movement as continuous streams
2. **Global Wind Vectors** (`global-wind-vectors.html`) - Traditional vector arrows with animated particles

## Features

### Wind Flow Visualization
- **Particle-based animation**: Thousands of particles flow according to wind vectors
- **Smooth trails**: Particles leave fading trails showing wind paths
- **Real data support**: Loads wind data from CSV files with U/V components
- **Performance optimized**: Spatial indexing for fast interpolation with large datasets
- **Interactive controls**: Adjust particle count, animation speed, and trail persistence

### Global Wind Vectors
- **Dual visualization**: Both particles and vector arrows
- **Vector scaling**: Adjustable arrow sizes
- **Speed-based coloring**: Blue (slow) → Orange (moderate) → Red (fast)
- **Toggle layers**: Show/hide particles or vectors independently

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
├── wind-flow-visualization.html
├── global-wind-vectors.html
├── uv.csv (your wind data)
└── README.md
```

### 2. Prepare Wind Data
- Name your wind data file `uv.csv`
- Ensure it follows the format described above
- Large datasets (>100k points) will be automatically sampled for performance

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
Navigate to:
- Wind Flow: `http://localhost:8888/wind-flow-visualization.html`
- Vector View: `http://localhost:8888/global-wind-vectors.html`

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

For true temporal animation, you would need:
- Multiple timestamps of wind data
- Time interpolation between frames
- Dynamic wind field updates

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

### Wind Flow Visualization
- **Pause/Play**: Stop or resume animation
- **Particle Count**: 1,000-10,000 particles
- **Speed**: Animation speed multiplier (0.1x-3x)
- **Fade Speed**: Trail persistence (0.9-0.99)

### Global Wind Vectors
- **Show Particles/Vectors**: Toggle visualization layers
- **Particle Count**: Number of animated particles
- **Animation Speed**: Particle movement speed
- **Vector Scale**: Size of arrow indicators

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