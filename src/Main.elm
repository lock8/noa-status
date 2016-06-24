module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.App exposing (..)
import Task exposing (Task)
import HttpBuilder exposing (..)
import Json.Decode exposing ((:=))
import Json.Decode as Decode

import Debug exposing (..)

type Msg
  = NoOp
  | GetStatus
  | Error (HttpBuilder.Error String)
  | Fetched (HttpBuilder.Response (List (String, String)))

type alias Model =
  { status : List (String, String)
  }

main = Html.App.program
  { init = init
  , update = update
  , view = view
  , subscriptions = \_ -> Sub.none
  }

init : (Model, Cmd Msg)
init = (Model []) ! []

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      { model | status = [] } ! []
    GetStatus ->
      model ! [getStatus]
    Error err ->
      model ! []
    Fetched resp ->
      { model | status = resp.data } ! []

view : Model -> Html Msg
view model =
  div []
    [ div [] [text (toString model.status)]
    , button [ onClick GetStatus ] [ text "Status?" ]
    , button [ onClick NoOp ] [ text "Clear" ]
    ]

itemsDecoder : Decode.Decoder (List (String, String))
itemsDecoder = Decode.keyValuePairs Decode.string

getStatus : Cmd Msg
getStatus =
  let
    testUrl = "https://chjglxvc66.execute-api.eu-west-1.amazonaws.com/test/status"
  in
    HttpBuilder.get testUrl
      |> send (jsonReader itemsDecoder) stringReader
      |> Task.perform Error Fetched
