module View exposing (view)

import Html exposing (..)
import Html.Events exposing (..)

import Message exposing (..)
import Model exposing (Model)

view : Model -> Html Msg
view model =
  div []
    [ div [] [text (toString model.status)]
    , button [ onClick GetStatus ] [ text "Status?" ]
    , button [ onClick NoOp ] [ text "Clear" ]
    ]
