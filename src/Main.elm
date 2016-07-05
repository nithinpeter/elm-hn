import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing ( onClick )

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
type alias Model = { count : Int }

-- INIT
init: Int -> (Model, Cmd Msg)
init count =
  (Model count, Cmd.none)


-- UPDATE
type Msg = NoOp | Increment

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> (model, Cmd.none)
    Increment -> (model, Cmd.none)


-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib
view : Model -> Html Msg
view model =
  div [ class "container", style [("margin-top", "30px"), ( "text-align", "center" )] ][    -- inline CSS (literal)
    div [ class "row" ][
      div [ class "col-xs-12" ][
        div [ class "jumbotron" ][
          hello model.count
        ]
      ]
    ]
  ]

-- SUBSCRIPTIONS  

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- CSS STYLES
styles : { img : List ( String, String ) }
styles =
  {
    img =
      [ ( "width", "33%" )
      , ( "border", "4px solid #337AB7")
      ]
  }

