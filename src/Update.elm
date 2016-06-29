module Update exposing (update)

import Dict exposing (Dict)

import Model exposing (Model)
import Message exposing (..)
import Command exposing (statusTask)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GetStatus _ ->
      model ! [statusTask]

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
        -- FIXME I think we can do better here.
        message = "Oops, something went wrong ... try again!"
      } ! []

    Fetched response ->
      { model |
          status   = [],
          message  = "Refreshed just now.",
          lastPoll = 0
      } ! []
