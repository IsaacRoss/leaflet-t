module Main exposing (..)

import Html exposing (program)
import Leaflet.Types
    exposing
        ( LatLng
        , ZoomPanOptions
        , MarkerOptions
        , defaultZoomPanOptions
        , defaultMarkerOptions
        )
import Leaflet.Ports
import Html exposing (div, button, text, Html, h3)
import Html.Events exposing (onClick)
import Dict exposing (Dict)


type alias Model =
    { latLng : LatLng
    , zoomPanOptions : ZoomPanOptions
    , markers : Dict Int ( LatLng, String )
    }


birminghamLatLng : LatLng
birminghamLatLng =
    ( 33.5207, -86.8025 )


boulderLatLng : LatLng
boulderLatLng =
    ( 40.015, -105.2705 )


init : ( Model, Cmd Msg )
init =
    ( { latLng = birminghamLatLng
      , zoomPanOptions = defaultZoomPanOptions
      , markers = Dict.empty
      }
    , Cmd.none
    )


type Msg
    = SetLatLng LatLng
    | GetCenter LatLng
    | AddMarker ( Int, LatLng, String )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetLatLng latLng ->
            ( { model | latLng = latLng }
            , Leaflet.Ports.setView ( latLng, 13, model.zoomPanOptions )
            )

        GetCenter latLng ->
            ( { model | latLng = latLng }, Cmd.none )

        AddMarker ( id, latLng, popupText ) ->
            let
                newModel =
                    addMarker ( id, latLng, popupText ) model
            in
                ( newModel
                , Leaflet.Ports.setMarkers <|
                    markersAsOutboundType newModel.markers
                )


addMarker : ( Int, LatLng, String ) -> Model -> Model
addMarker ( id, markerOptions, popupText ) model =
    { model | markers = Dict.insert id ( markerOptions, popupText ) model.markers }


markersAsOutboundType : Dict Int ( LatLng, String ) -> List ( Int, LatLng, MarkerOptions, String )
markersAsOutboundType markers =
    Dict.toList markers
        |> List.map (\( id, ( latLng, popupText ) ) -> ( id, latLng, defaultMarkerOptions, popupText ))


main : Program Never Model Msg
main =
    program { view = view, init = init, update = update, subscriptions = subscriptions }


subscriptions : msg -> Sub Msg
subscriptions =
    always <| Leaflet.Ports.getCenter GetCenter


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick <| SetLatLng birminghamLatLng ] [ text "Set Map Location to Birmingham" ]
        , button [ onClick <| SetLatLng boulderLatLng ] [ text "Set Map Location to Boulder" ]
        , button [ onClick <| AddMarker ( 1, birminghamLatLng, "Birmingham, AL" ) ] [ text "Ad Marker for Birmingham" ]
        , button [ onClick <| AddMarker ( 2, boulderLatLng, "Boulder, CO" ) ] [ text "Ad Marker for Boulder" ]
        , h3 [] [ text <| toString model.latLng ]
        ]
