module Util exposing (..)

import Task exposing (Task)
import Json.Decode as Decode
import HttpBuilder exposing (send, stringReader, jsonReader, Error, Response)

import Message exposing (Msg(Error, Fetched))

testURL : String
testURL = "https://chjglxvc66.execute-api.eu-west-1.amazonaws.com/test/status"

prodURL : String
prodURL = "https://chjglxvc66.execute-api.eu-west-1.amazonaws.com/prod/status"

itemsDecoder : Decode.Decoder (List (String, String))
itemsDecoder = Decode.keyValuePairs Decode.string

statusTask : String -> Task (Error String) (Response (List (String, String)))
statusTask url =
  send (jsonReader itemsDecoder) stringReader (HttpBuilder.get url)

getStatus : Cmd Msg
getStatus =
  let
   task1 = statusTask testURL
   task2 = statusTask prodURL
   finalTask = Task.sequence [task1, task2]
  in
    Task.perform Error Fetched finalTask
