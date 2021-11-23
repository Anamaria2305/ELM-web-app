module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Http
import Json.Decode as De
import Model exposing (..)
import Model.Event as Event
import Model.Event.Category as EventCategory exposing (set)
import Model.PersonalDetails as PersonalDetails
import Model.Repo as Repo exposing (decodeRepo)


type Msg
    = GetRepos
    | GotRepos (Result Http.Error (List Repo.Repo))
    | SelectEventCategory EventCategory.EventCategory
    | DeselectEventCategory EventCategory.EventCategory


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
getRepos : Cmd Msg
getRepos = Http.get
    { url = "https://api.github.com/users/rtfeldman/repos?sort=pushed&direction=desc"
    , expect = Http.expectJson GotRepos (De.list decodeRepo)
    }

init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel, getRepos)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetRepos ->
            ( model, getRepos )
        GotRepos (Ok res)  ->
            ( {model|repos=res}, Cmd.none )
        GotRepos (Err err) ->
            ( model , Cmd.none)
        SelectEventCategory category ->
            ( {model|selectedEventCategories = set category True model.selectedEventCategories }, Cmd.none )
        DeselectEventCategory category ->
            ( {model|selectedEventCategories = set category False model.selectedEventCategories }, Cmd.none )


eventCategoryToMsg : ( EventCategory.EventCategory, Bool ) -> Msg
eventCategoryToMsg ( event, selected ) =
    if selected then
        SelectEventCategory event

    else
        DeselectEventCategory event


view : Model -> Html Msg
view model =
    let
        eventCategoriesView =
            EventCategory.view model.selectedEventCategories |> Html.map eventCategoryToMsg

        eventsView =
            model.events
                |> List.filter (.category >> (\cat -> EventCategory.isEventCategorySelected cat model.selectedEventCategories))
                |> List.map Event.view
                |> div []
                |> Html.map never

        reposView =
            model.repos
                |> Repo.sortByStars
                |> List.take 5
                |> List.map Repo.view
                |> div []
    in
    div []
        [ PersonalDetails.view model.personalDetails
        , h3 [] [ text "Experience" ]
        , eventCategoriesView
        , eventsView
        , h3 [] [ text "My top repos" ]
        , reposView
        ]
