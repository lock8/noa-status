module Update exposing (update)

import Dict exposing (Dict)

import Model exposing (Model)
import Message exposing (..)
import Util exposing (getStatus)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GetStatus _ ->
      model ! [getStatus]

    UpdateMessage _ ->
        let
          newTime    = model.lastPoll + 1
          minutesMsg = if newTime > 1 then " minutes ago." else " minute ago."
          fullMsg    = "Refreshed " ++ (toString newTime) ++ minutesMsg
        in
        { model |
          message  = fullMsg,
          lastPoll = newTime
        } ! []

    Error err ->
      { model |
        message = "Oops, something went wrong ... try again!"
      } ! []

    Fetched response ->
      let
        xs = List.concat (List.map .data response)
        ys = Dict.fromList xs
        velodrome_test  = Dict.get "velodrome-testing-api-lb" ys
        velodrome_prod  = Dict.get "velodrome-production-api-lb" ys
        locksocket_test = Dict.get "locksocket-elb-testing" ys
        locksocket_prod = Dict.get "locksocket-elb" ys
        built =
          [ ("velodrome", velodrome_test, velodrome_prod)
          , ("locksocket", locksocket_test, locksocket_prod)
          ]
      in
      { model |
          status   = built,
          message  = "Refreshed just now.",
          lastPoll = 0
      } ! []
