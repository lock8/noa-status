module Update exposing (update)

import Model exposing (..)
import Message exposing (..)
import Command exposing (statusTask)
import Util exposing (buildStatus, getCond)

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
      let
          responses = List.concat response
          statuses  = List.map buildStatus responses
      in
      { model |
          status   = statuses,
          message  = "Refreshed just now.",
          lastPoll = 0
      } ! []
