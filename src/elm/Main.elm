module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as Attr



--- Main


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



--- Msg


type Msg
    = Nope



--- Model


type alias Model =
    String


init : () -> ( Model, Cmd Msg )
init () =
    ( "elm rules!", Cmd.none )



--- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Nope ->
            ( model, Cmd.none )



--- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



--- View


view : Model -> Html Msg
view model =
    div []
        [ header []
            [ nav []
                [ ul []
                    []
                ]
            ]
        , Html.main_ [ Attr.class "page-main" ]
            [ h1 [] [ text model ] ]
        , footer [] []
        ]
