module Components.NewsItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http

type alias Model =
  { title : String }


type Msg = RequestDetails 
  | RequestDetailsSuccess Model
  | RequestDetailsFail Http.Error 

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =

  case msg of
    RequestDetails ->
      (model, Cmd.none)
    RequestDetailsSuccess data->
      (model, Cmd.none)
    RequestDetailsFail error ->
      (model, Cmd.none)



view : Int -> Html a
view model =
  div
    [ class "h1" ]
    [ text (toString model) ]
