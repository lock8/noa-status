module Update exposing (update)

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
      { model | message = "Oops, something went wrong ... try again!" } ! []

    Fetched response ->
      let
        statuses = List.concat (List.map .data response)
      in
      { model |
          status  = statuses,
          message = "Refreshed just now."
      } ! []
