module View exposing (view)

import Html exposing (..)

import Message exposing (Msg)
import Model exposing (Model)

view : Model -> Html Msg
view model = div [] [text (toString model)]
