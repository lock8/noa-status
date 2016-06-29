module View exposing (view)

import String

import Html exposing (..)

import Message exposing (Msg)
import Model exposing (Model)

view : Model -> Html Msg
view model = div [] [text "Hello, World!"]
