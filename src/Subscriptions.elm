module Subscriptions exposing (subscriptions)

import Model   exposing (Model)
import Message exposing (Msg)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
