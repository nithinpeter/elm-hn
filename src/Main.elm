import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing ( onClick )
import Http
import Json.Decode exposing (list, int) 

import Task

-- component import example
import Components.Hello exposing ( hello )


-- APP
main : Program Never
main =
    Html.program
    { init = init 10
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL
type alias Model = { count : Int, list: (List Int) }

-- INIT
init: Int -> (Model, Cmd Msg)
init count =
  (Model count [], getTopNews)


-- UPDATE
type Msg = NoOp | Increment | Request | RequestSuccess (List Int) | RequestFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> 
      (model, Cmd.none)
    Increment -> 
      (model, Cmd.none)
    Request ->
      (model, Cmd.none)
    RequestSuccess list->
      (Model model.count list, Cmd.none)
    RequestFail error->
      (Model model.count [], Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
  div [ class "container", style [("margin-top", "30px"), ( "text-align", "center" )] ][    -- inline CSS (literal)
    div [ class "row" ][
      div [ class "col-xs-12" ][
        div [ class "jumbotron" ][
          hello model.count
        ],
        text (toString model.list)
      ]
    ]
  ]

viewList: Int -> Html Msg
viewList item =
  div [] [text (toString item)]

-- SUBSCRIPTIONS  

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- HTTP

getTopNews =
  let 
    url = 
      "https://hacker-news.firebaseio.com/v0/topstories.json"
  in
    Task.perform RequestFail RequestSuccess (Http.get (Json.Decode.list int) url)


-- CSS STYLES
styles : { img : List ( String, String ) }
styles =
  {
    img =
      [ ( "width", "33%" )
      , ( "border", "4px solid #337AB7")
      ]
  }

