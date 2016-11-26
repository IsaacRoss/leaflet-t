module Leaflet.Types exposing (LatLng, ZoomPanOptions, defaultZoomPanOptions)


type alias LatLng =
    ( Float, Float )


type alias ZoomOptions =
    { animate : Bool
    }


type alias PanOptions =
    { animate : Bool
    , duration : Float
    , easeLinearity : Float
    , noMoveStart : Bool
    }


type alias ZoomPanOptions =
    { reset : Bool
    , pan : PanOptions
    , zoom : ZoomOptions
    , animate : Bool
    }


defaultZoomPanOptions : ZoomPanOptions
defaultZoomPanOptions =
    { reset = False
    , pan = defaultPanOptions
    , zoom = defaultZoomOptions
    , animate = True
    }


defaultPanOptions : PanOptions
defaultPanOptions =
    { animate = True
    , duration = 0.25
    , easeLinearity = 0.25
    , noMoveStart = False
    }


defaultZoomOptions : ZoomOptions
defaultZoomOptions =
    { animate = True }
