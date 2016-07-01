module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown

import Message exposing (Msg)
import Model exposing (..)

import Bootstrap.Html exposing (..)
import Html.Shorthand exposing (..)

view : Model -> Html Msg
view model = div [id "outermost"]
  [ containerFluid_
    [ colMdOffset_ 12 0 6 3 6 3
      [ header model.message
      , operationalMessage model.status
      ]
    , colMdOffset_ 12 0 6 3 6 3
      [ bodyHeader
      , statusTable model.status
      ]
    , colMdOffset_ 12 0 6 3 6 3 [footer]
    ]
  ]

header : String -> Html Msg
header msg = div [id "header"]
  [ colMd_ 8 6 4
    [ img [class "img-responsive", id "logo", src "img/logo.png"] []
    ]
  , colMd_ 12 6 8 [h4 [id "model-message" ] [text msg]]
  ]

operationalMessage : List Status -> Html Msg
operationalMessage statuses =
  div [id "operational-message"]
  [
  ]

bodyMarkdown : String
bodyMarkdown = """
#### What is this site?

We monitor the status of `api.lock8.me` and all its related services.
If there are interruptions in service, we'll let you know here.
"""

bodyHeader : Html Msg
bodyHeader =
  div [id "bodyHeader"] [Markdown.toHtml [] bodyMarkdown]

statusTable : List Status -> Html Msg
statusTable statuses =
  div [id "statusTable"]
  [ tableStriped' ".table-responsive"
    [ thead_
      [ th' {class = "text-left"} [ text "Service" ]
      , th' {class = "text-left"} [ text "Testing" ]
      , th' {class = "text-left"} [ text "Production" ]
      ]
    , tbody_ (List.map generateStatusTable statuses)
    ]
  ]

generateStatusTable : Status -> Html Msg
generateStatusTable status =
  let
    label health = case health of
      Healthy     -> {class="label label-pill label-success"}
      Unhealthy   -> {class="label label-pill label-warning"}
      Down        -> {class="label label-pill label-danger"}
      HealthError -> {class="label label-pill label-default"}
  in
  tr_
  [ td_ [ span' {class="service-name"} [text (toString status.service)] ]
  , td_ [ span' (label status.testHealth) [text (toString status.testHealth)] ]
  , td_ [ span' (label status.testHealth) [text (toString status.prodHealth)] ]
  ]

footer : Html Msg
footer =
  div [id "footer"]
  [
    colMd_ 6 6 6
    [ ul [id "footer-menu"]
      [ li [] [ a [href "#"] [text "Home"] ]
      , li [] [ a [href "#"] [text "Blog"] ]
      ]
    ]
  , colMd_ 6 6 6 [p [id "copyright"]
    [ text "© 2016 Noa Technologies."]
    ]
  ]
