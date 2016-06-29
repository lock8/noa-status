module Command exposing (statusTask)

import Http
import Task exposing (Task)
import Json.Decode as Decode

import Message exposing (..)

responseDecoder : Decode.Decoder (List (String, String))
responseDecoder = Decode.keyValuePairs Decode.string

getStatus : String -> Task Http.Error LambdaResponse
getStatus url =
  Http.get responseDecoder url

statusTask : Cmd Msg
statusTask =
  let
   testURL = "https://chjglxvc66.execute-api.eu-west-1.amazonaws.com/test/status"
   prodURL = "https://chjglxvc66.execute-api.eu-west-1.amazonaws.com/prod/status"

   task1 = getStatus testURL
   task2 = getStatus prodURL

   finalTask = Task.sequence [task1, task2]
  in
    Task.perform Error Fetched finalTask

