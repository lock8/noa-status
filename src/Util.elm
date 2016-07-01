module Util exposing (buildStatus)

import Dict exposing (Dict)
import Maybe exposing (Maybe)

import Model exposing (..)

cond : String -> Condition
cond c =
  case c of
    "HEALTHY"   -> Healthy
    "UNHEALTHY" -> Unhealthy
    "DOWN"      -> Down
    _           -> HealthError

buildStatus : List (String, String) -> List Status
buildStatus resp =
  let
    respDict = Dict.fromList resp
    velodromeTestHealth  = cond (Maybe.withDefault "DOWN" (Dict.get "velodrome-testing-api-lb" respDict))
    velodromeProdHealth  = cond (Maybe.withDefault "DOWN" (Dict.get "velodrome-production-api-lb" respDict))
    locksocketTestHealth = cond (Maybe.withDefault "DOWN" (Dict.get "locksocket-elb-testing" respDict))
    locksocketProdHealth = cond (Maybe.withDefault "DOWN" (Dict.get "locksocket-elb" respDict))
  in
     [ (Status Velodrome velodromeTestHealth velodromeProdHealth)
     , (Status Locksocket locksocketTestHealth locksocketProdHealth)
     ]
