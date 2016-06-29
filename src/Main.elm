module Main exposing (main)

import Html.App

import Model exposing (init)
import View exposing (view)
import Update exposing (update)
import Subscriptions exposing (subscriptions)

main = Html.App.program
  { init = init
  , update = update
  , view = view
  , subscriptions = subscriptions
  }
