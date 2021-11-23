module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)


type EventCategory
    = Academic
    | Work
    | Project
    | Award


eventCategories =
    [ Academic, Work, Project, Award ]


{-| Type used to represent the state of the selected event categories
-}
type SelectedEventCategories
    = SelectedEventCategories  Bool Bool Bool Bool


{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected = SelectedEventCategories True True True True

    --Debug.todo "Implement Model.Event.Category.allSelected"


{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category current =
     case category of
         Academic-> case current of
                        SelectedEventCategories True _ _ _ ->True
                        _->False
         Work->case current of
                        SelectedEventCategories  _ True _ _ ->True
                        _->False
         Project->case current of
                        SelectedEventCategories _ _ True _ ->True
                        _->False
         Award->case current of
                       SelectedEventCategories _ _ _ True ->True
                       _->False
    --Debug.todo "Implement Model.Event.Category.isEventCategorySelected"


{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current =
    let
      (SelectedEventCategories  academic work project award)=current
    in
    case category of
        Academic-> SelectedEventCategories value work project award
        Work->SelectedEventCategories academic value project award
        Project->SelectedEventCategories academic work value award
        Award->SelectedEventCategories academic work project value
    --Debug.todo "Implement Model.Event.Category.set"


checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]


view : SelectedEventCategories -> Html ( EventCategory, Bool )
view model =
    let
         (SelectedEventCategories  academic work project award)=model
    in
    div [] [
    checkbox "Academic" academic Academic
    ,checkbox "Work" work Work
    ,checkbox "Project" project Project
    ,checkbox "Award" award Award
    ]
    --Debug.todo "Implement the Model.Event.Category.view function"
