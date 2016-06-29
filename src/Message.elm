module Message exposing (..)

import Http
import Time exposing (Time)

type alias LambdaResponse =
  List (String, String)

type Msg
  = GetStatus Time
  | UpdateMessage Time
  | Error Http.Error
  | Fetched (List LambdaResponse)
