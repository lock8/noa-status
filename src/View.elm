module View exposing (view)

import String

import Html exposing (..)

import Message exposing (Msg)
import Model exposing (Model)

buildList : (String, Maybe String, Maybe String) -> Html a
buildList status =
  case status of
    (s, (Just h1), (Just h2)) ->
      h4 []
      [ text s
      , ul []
        [ li [] [ text ("Test: " ++ (String.toLower h1)) ]
        , li [] [ text ("Production: " ++ (String.toLower h2))]
        ]
      ]
    (_, Maybe.Nothing, _) -> p [] [text "Ugh!"]
    (_, _, Maybe.Nothing) -> p [] [text "Ugh!"]

view : Model -> Html Msg
view model =
  div []
  [ div [] [ text model.message ]
  , div [] (List.map buildList model.status)
  ]
  |> Debug.log (toString model.status)
