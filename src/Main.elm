module Main exposing (..)

import Html exposing (program)
import Leaflet.Types exposing (LatLng, ZoomPanOptions, defaultZoomPanOptions)
import Leaflet.Ports
import Html exposing (div, button, text, Html)
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetLatLng latLng ->
            ( { model | latLng = latLng }
            , Leaflet.Ports.setView ( latLng, 13, model.zoomPanOptions )
            )


main : Program Never Model Msg
main =
    program { view = view, init = init, update = update, subscriptions = subscriptions }


subscriptions : a -> Sub msg
subscriptions =
    \_ -> Sub.none


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick <| SetLatLng birminghamLatLng ] [ text "Set Map Location to Birmingham" ]
        , button [ onClick <| SetLatLng boulderLatLng ] [ text "Set Map Location to Boulder" ]
        ]
