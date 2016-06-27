module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)

import Message exposing (..)
import Model exposing (..)


view : Model -> Html Msg
view model =
  div []
  [ div [] [ text model.message ]
  , div [] [ text (toString model.status) ]
  ]
