import React, { useEffect, useRef, useState } from 'react'
import { MapContainer, TileLayer, ImageOverlay, useMap } from 'react-leaflet'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import 'leaflet-draw/dist/leaflet.draw.css'
import 'leaflet-draw'
import MapSearch from './MapSearch'
import MapLayerControl from './MapLayerControl'

// Fix for default markers
import icon from 'leaflet/dist/images/marker-icon.png'
import iconShadow from 'leaflet/dist/images/marker-shadow.png'

let DefaultIcon = L.icon({
  iconUrl: icon,
  shadowUrl: iconShadow,
  iconSize: [25, 41],
  iconAnchor: [12, 41]
})

L.Marker.prototype.options.icon = DefaultIcon

// Component to handle drawing controls
function DrawControl({ onGeometrySelected, onClearSelection }) {
  const map = useMap()
  const drawnItemsRef = useRef(new L.FeatureGroup())

  useEffect(() => {
    const drawnItems = drawnItemsRef.current
    map.addLayer(drawnItems)

    // Add draw control
    const drawControl = new L.Control.Draw({
      position: 'topright',
      draw: {
        rectangle: true,
        polygon: true,
        circle: false,
        circlemarker: false,
        marker: false,
        polyline: false,
      },
      edit: {
        featureGroup: drawnItems,
        edit: false,
        remove: true,
      }
    })
    map.addControl(drawControl)

    // Handle draw created event
    map.on(L.Draw.Event.CREATED, (e) => {
      const layer = e.layer
      
      // Clear previous drawings
      drawnItems.clearLayers()
      
      // Add new layer
      drawnItems.addLayer(layer)
      
      // Get GeoJSON
      const geoJSON = layer.toGeoJSON()
      
      // Pass geometry to parent
      onGeometrySelected(geoJSON.geometry)
    })

    // Handle delete event
    map.on(L.Draw.Event.DELETED, () => {
      onClearSelection()
    })

    return () => {
      map.removeControl(drawControl)
      map.removeLayer(drawnItems)
      map.off(L.Draw.Event.CREATED)
      map.off(L.Draw.Event.DELETED)
    }
  }, [map, onGeometrySelected, onClearSelection])

  return null
}

// Component to handle map view updates
function MapController({ bounds, flyToLocation }) {
  const map = useMap()
  
  useEffect(() => {
    if (bounds && bounds.length === 2) {
      map.fitBounds(bounds, { padding: [50, 50] })
    }
  }, [bounds, map])
  
  useEffect(() => {
    if (flyToLocation) {
      map.flyTo([flyToLocation.lat, flyToLocation.lon], flyToLocation.zoom, {
        duration: 1.5
      })
    }
  }, [flyToLocation, map])
  
  return null
}

// NDVI Legend component
function NDVILegend() {
  const legendItems = [
    { color: '#8B4513', label: '< 0.2 - Почва, вода' },
    { color: '#FFD700', label: '0.2-0.4 - Низкая вегетация' },
    { color: '#ADFF2F', label: '0.4-0.6 - Средняя вегетация' },
    { color: '#228B22', label: '> 0.6 - Здоровая вегетация' },
  ]
  
  return (
    <div className="legend">
      <h3>NDVI Индекс</h3>
      {legendItems.map((item, index) => (
        <div key={index} className="legend-item">
          <div className="legend-color" style={{ background: item.color }}></div>
          <span className="legend-label">{item.label}</span>
        </div>
      ))}
    </div>
  )
}

function MapView({ onGeometrySelected, analysisResult, onClearSelection }) {
  const [showLegend, setShowLegend] = useState(false)
  const [flyToLocation, setFlyToLocation] = useState(null)

  useEffect(() => {
    if (analysisResult?.image_url) {
      setShowLegend(true)
    } else {
      setShowLegend(false)
    }
  }, [analysisResult])

  const handleLocationSelect = (location) => {
    setFlyToLocation(location)
    // Reset after animation to allow re-selecting same location
    setTimeout(() => setFlyToLocation(null), 2000)
  }

  return (
    <div style={{ height: '100%', width: '100%', position: 'relative' }}>
      <MapContainer
        center={[55.7558, 37.6173]}
        zoom={10}
        style={{ height: '100%', width: '100%' }}
        zoomControl={true}
      >
        <TileLayer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        />
        
        <DrawControl 
          onGeometrySelected={onGeometrySelected}
          onClearSelection={onClearSelection}
        />

        {/* Display NDVI result as image overlay */}
        {analysisResult?.image_url && analysisResult?.bounds && (
          <ImageOverlay
            url={analysisResult.image_url}
            bounds={analysisResult.bounds}
            opacity={0.7}
          />
        )}
        
        {/* Map controller for bounds and location */}
        <MapController 
          bounds={analysisResult?.bounds} 
          flyToLocation={flyToLocation}
        />
        
        {/* Layer control */}
        <MapLayerControl />
      </MapContainer>
      
      {/* Search component */}
      <MapSearch onLocationSelect={handleLocationSelect} />
      
      {/* Show legend when NDVI result is displayed */}
      {showLegend && <NDVILegend />}
    </div>
  )
}

export default MapView
