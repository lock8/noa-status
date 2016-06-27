module Message exposing (..)

import HttpBuilder exposing (Error, Response)
import Time exposing (Time)

type Msg
  = GetStatus Time
  | UpdateMessage Time
  | Error (Error String)
  | Fetched (List (Response (List (String, String))))
