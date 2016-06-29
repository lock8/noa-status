module Util exposing (buildStatus, getCond)

import Model exposing (..)

getCond : String -> Condition
getCond cond =
  case cond of
    "HEALTHY"   -> Healthy
    "UNHEALTHY" -> Unhealthy
    "DOWN"      -> Down
    _           -> Debug.crash "NotImplementedError: Unknown Condition!"

buildStatus : (String, String) -> Status
buildStatus resp =
  case resp of
    ("locksocket-elb", cond)              -> Status Locksocket Production (getCond cond)
    ("locksocket-elb-testing", cond)      -> Status Locksocket Testing    (getCond cond)
    ("velodrome-testing-api-lb", cond)    -> Status Velodrome  Testing    (getCond cond)
    ("velodrome-production-api-lb", cond) -> Status Velodrome  Production (getCond cond)
    (_, _) -> Debug.crash "NotImplementedError: Unknown Service!"
