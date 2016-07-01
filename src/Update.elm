module Update exposing (update)

import Http exposing (..)

import Model exposing (..)
import Message exposing (..)
import Command exposing (statusTask)
import Util exposing (buildStatus)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    GetStatus _ ->
      model ! [statusTask]

    -- FIXME: If there is some (Error err), this will still tick the message
    --        Also, the time will never be reset to 0, and kepe ticking
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
      let
        msg = case err of
          NetworkError ->
            "The network is experiencing problems, please try again later."
          Timeout ->
            "The connection timed out, please try again."
          UnexpectedPayload _   ->
            "Received a bad response, ask for help at support@noa.one."
          BadResponse       _ _ ->
            "Received an unexpected response, ask for help at support@noa.one."
      in
      { model |
        message = msg
      } ! []

    Fetched response ->
      { model |
          status   = List.concat response |> buildStatus,
          message  = "Refreshed just now.",
          lastPoll = 0
      } ! []
