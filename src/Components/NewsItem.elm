module Components.NewsItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Task
import Json.Decode as Json 

type alias Model = Int


init: Int -> (Model, Cmd Msg)
init newsItemId =
  ( newsItemId
    , getNewsDetails newsItemId
  ) 

type Msg = Loading 
  | GetItemSuccess Model
  | GetItemFailure Http.Error 

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =

  case msg of
    Loading ->
      (model, Cmd.none)
    GetItemSuccess data->
      (model, Cmd.none)
    GetItemFailure error ->
      (model, Cmd.none)



view : Int -> Html a
view model =
  div
    [ class "h1" ]
    [ text (toString model) ]


-- HTTP

getNewsDetails : Int -> Cmd Msg 
getNewsDetails itemId=
  let 
    url = 
      "https://hacker-news.firebaseio.com/v0/item/" ++ toString itemId ++ ".json"
  in
    Task.perform GetItemFailure GetItemSuccess (Http.get decodeUrl url)

decodeUrl : Json.Decoder Int
decodeUrl =
  Json.at ["title"] Json.int