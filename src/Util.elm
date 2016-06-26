module Util exposing (itemsDecoder, getStatus)

import Task exposing (Task)
import Json.Decode as Decode
import HttpBuilder exposing (..)

import Message exposing (..)

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
