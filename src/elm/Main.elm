module Main exposing (main)

import Browser
import Dict
import Html
import Html.Attributes as Attr
import Html.Events
import PackagingUnit



--- Main


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update2
        , subscriptions = subscriptions
        }



--- Msg


type Msg
    = Nope
    | AddArticle String



--- Model


type alias Model =
    { articles : List Article
    , shoppingCard : Dict.Dict String Int
    }


type alias Article =
    { id : String
    , name : String
    , unit : PackagingUnit.PackagingUnit
    }


type alias CardItem =
    ( String, Int )


init : () -> ( Model, Cmd Msg )
init () =
    ( { articles =
            [ { id = "beans"
              , name = "Kidney Bohnen"
              , unit = PackagingUnit.Can
              }
            , { id = "noodles"
              , name = "Nudeln"
              , unit = PackagingUnit.Gram
              }
            , { id = "apple"
              , name = "Apfel"
              , unit = PackagingUnit.Quantity
              }
            , { id = "vly"
              , name = "Vly"
              , unit = PackagingUnit.Quantity
              }
            , { id = "knobi"
              , name = "Knoblauch"
              , unit = PackagingUnit.Quantity
              }
            , { id = "toipa"
              , name = "Toilettenpapier"
              , unit = PackagingUnit.Quantity
              }
            ]
      , shoppingCard = Dict.fromList [ ( "beans", 2 ), ( "noodles", 500 ) ]
      }
    , Cmd.none
    )



--- Update


update2 : Msg -> Model -> ( Model, Cmd Msg )
update2 msg model =
    case msg of
        Nope ->
            ( model, Cmd.none )

        AddArticle articleId ->
            let
                updatedShoppingCard =
                    model.shoppingCard
                        |> Dict.update articleId
                            (\quantity ->
                                case quantity of
                                    Just n ->
                                        Just (n + 1)

                                    Nothing ->
                                        Just 1
                            )
            in
            ( { model | shoppingCard = updatedShoppingCard }, Cmd.none )



--- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



--- View


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.header []
            [ Html.nav []
                [ Html.ul []
                    []
                ]
            ]
        , pageMain model
        , Html.footer [] []
        ]


pageMain : Model -> Html.Html Msg
pageMain model =
    Html.main_ [ Attr.class "page-main" ]
        [ Html.h1 [] [ Html.text "elm rulat" ]
        , Html.div [ Attr.class "" ]
            [ articlesListView model.articles
            , shoppingListView model.shoppingCard model.articles
            ]
        ]


articlesListView : List Article -> Html.Html Msg
articlesListView articles =
    Html.section []
        [ Html.ul []
            (articles
                |> List.map (\article -> Html.li [ Html.Events.onClick (AddArticle article.id) ] [ Html.text article.name ])
            )
        ]


shoppingListView : Dict.Dict String Int -> List Article -> Html.Html Msg
shoppingListView shoppingCard articles =
    let
        listItems =
            shoppingCard
                |> Dict.toList
                |> List.map
                    (\( articleId, n ) ->
                        articles
                            |> List.filter (\article -> article.id == articleId)
                            |> List.head
                            |> Maybe.map (\{ name, unit } -> ( articleId, PackagingUnit.toString unit n ++ " " ++ name ))
                    )
                |> List.filterMap identity
                |> List.map (\( articleId, item ) -> Html.li [ Html.Events.onClick (AddArticle articleId) ] [ Html.text item ])
    in
    Html.section []
        [ Html.ul []
            listItems
        ]
