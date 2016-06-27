module Subscriptions exposing (subscriptions)

import Time exposing (Time, minute)

import Model exposing (Model)
import Message exposing (Msg(GetStatus, UpdateMessage))

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch
  [ Time.every minute UpdateMessage
  , Time.every (minute * 3) GetStatus
  ]
