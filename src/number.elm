import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import Random


main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
    
toDefaultInt: Int -> String -> Int
toDefaultInt default string =
  Result.withDefault default (String.toInt string)

-- MODEL


type alias Model = {input : Int, num : Int}

init : (Model, Cmd Msg)
init = 
    ({input = 0, num = 0}, Cmd.none)


-- UPDATE


type Msg = IncrementNum Int
  | DecrementNum Int
  | SetNum Int
  | SetInput String
  | Roll


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    IncrementNum i ->
      ({model | num = model.num + i}, Cmd.none)

    DecrementNum i ->
      ({model | num = model.num - i}, Cmd.none)

    SetNum i ->
      ({model | num = i}, Cmd.none)

    Roll ->
      (model, Random.generate SetNum (Random.int -100 100))

    SetInput s ->
      ({model | input = toDefaultInt model.input s}, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ button [ onClick (DecrementNum 1) ] [ text "-" ]
    , button [ onClick (IncrementNum 1) ] [ text "+" ]
    , button [ onClick (SetNum 0) ] [ text "Reset" ]
    , button [ onClick Roll ] [ text "Random" ]
    , br [] []
    , formView model
    , h1 [] [ text ("The Number: " ++ toString model.num) ]
    , div [] [ text (toString model) ]
    , div [] [ text (toString Model) ]
    ]

formView : Model -> Html Msg
formView model =
  Html.form [ onSubmit (SetNum model.input) ]
    [ input [ placeholder "Enter a value to set me", onInput SetInput ] []
    , button [ onClick (SetNum model.input) ] [ text "Set" ]
    ]
