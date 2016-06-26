module Message exposing (..)

import HttpBuilder exposing (..)

type Msg
  = NoOp
  | GetStatus
  | Error (HttpBuilder.Error String)
  | Fetched (HttpBuilder.Response (List (String, String)))
