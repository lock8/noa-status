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
          UnexpectedPayload x   ->
            "Received a bad response, ask for help at support@noa.one."
          BadResponse       x y ->
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
