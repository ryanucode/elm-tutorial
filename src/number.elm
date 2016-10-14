import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

toDefaultInt: Int -> String -> Int
toDefaultInt default string =
  Result.withDefault default (String.toInt string)

-- MODEL


type alias Model = {input: Int, num: Int}


model : Model
model =
  {input = 0, num = 0}



-- UPDATE


type Msg = IncrementNum Int
  | DecrementNum Int
  | SetNum Int
  | SetInput String


update : Msg -> Model -> Model
update msg model =
  case msg of
    IncrementNum i ->
      {model | num = model.num + i}

    DecrementNum i ->
      {model | num = model.num - i}

    SetNum i ->
      {model | num = i}

    SetInput s ->
      {model | input = toDefaultInt model.input s}


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ button [ onClick (DecrementNum 1) ] [ text "-" ]
    , button [ onClick (IncrementNum 1) ] [ text "+" ]
    , button [ onClick (SetNum 0) ] [ text "Reset" ]
    , br [] []
    , input [ placeholder "Enter a value to set me", onInput SetInput ] []
    , button [ onClick (SetNum model.input) ] [ text "Set" ]
    , h1 [] [ text ("The Number: " ++ toString model.num) ]
    , div [] [ text (toString model) ]
    ]

