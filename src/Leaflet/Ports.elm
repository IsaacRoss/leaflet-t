port module Leaflet.Ports exposing (setView, getCenter, setMarkers)

import Leaflet.Types exposing (LatLng, ZoomPanOptions, MarkerOptions)


port setView : ( LatLng, Int, ZoomPanOptions ) -> Cmd msg


port setMarkers : List ( Int, LatLng, MarkerOptions, String ) -> Cmd msg


port getCenter : (LatLng -> msg) -> Sub msg
