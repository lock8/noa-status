module Command exposing (statusTask)

import Http
import Task exposing (Task)
import Json.Decode as Decode

import Message exposing (..)

responseDecoder : Decode.Decoder LambdaResponse
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

   -- FIXME Sequence will fail if one of the tasks fail. This isn't what we want
   --       but I wait for the `Task.parallel` stdlib function and will not use
   --       the complicated/hacky looking `elm-task-extra`: github.com/elm-lang/core/pull/224
   finalTask = Task.sequence [task1, task2]
  in
    Task.perform Error Fetched finalTask
