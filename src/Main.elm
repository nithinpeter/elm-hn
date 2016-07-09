import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing ( onClick )
import Http
import Json.Decode exposing (list, int) 

import Task

-- component import example
import Components.NewsItem as NewsItem
import Components.NewsItem as NewsItem exposing (..)


-- APP
main : Program Never
main =
    Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL
type alias Model = List Components.NewsItem

-- INIT
init: (Model, Cmd Msg)
init =
  (Model [], getTopNews)


-- UPDATE
type Msg = Request 
  | RequestSuccess (List Int) 
  | RequestFail Http.Error
  

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Request ->
      (model, Cmd.none)
    RequestSuccess list->
      let
        children = 
          list |> List.map (\id -> NewsItem.init id)
       in
        Model children 
    RequestFail error->
      (Model, Cmd.none)

    


-- VIEW

view : Model -> Html Msg
view model =
  div [ class "container", style [("margin-top", "30px"), ( "text-align", "center" )] ][    -- inline CSS (literal)
    div [ class "row" ][
      div [ class "col-xs-12" ][
        div [ class "jumbotron" ](
          List.map NewsItem.view model
        )
      ]
    ]
  ]


-- SUBSCRIPTIONS  

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- HTTP

getTopNews : Cmd Msg 
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

