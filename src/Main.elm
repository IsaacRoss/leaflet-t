module Main exposing (..)

import Html exposing (program)
import Leaflet.Types exposing (LatLng, ZoomPanOptions, defaultZoomPanOptions)
import Leaflet.Ports
import Html exposing (div, button, text, Html, h3)
import Html.Events exposing (onClick)


type alias Model =
    { latLng : LatLng
    , zoomPanOptions : ZoomPanOptions
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
      }
    , Cmd.none
    )


type Msg
    = SetLatLng LatLng
    | GetCenter LatLng


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetLatLng latLng ->
            ( { model | latLng = latLng }
            , Leaflet.Ports.setView ( latLng, 13, model.zoomPanOptions )
            )

        GetCenter latLng ->
            ( { model | latLng = latLng }, Cmd.none )


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
        , h3 [] [ text <| toString model.latLng ]
        ]
