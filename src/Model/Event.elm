module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, id, style)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"


sortByInterval : List Event -> List Event
sortByInterval events =
     let
        compareEvent : Event -> Event -> Order
        compareEvent ev1 ev2=
               Interval.compare ev1.interval ev2.interval
     in
     List.sortWith compareEvent events
    --Debug.todo "Implement Event.sortByInterval"


view : Event -> Html Never
view event =
     let
         eventURL  eU = case eU of
             Just a ->a
             Nothing -> ""
         isImportant iI= if iI then "event event-important"
             else "event"

     in
     --Desi in cerinta scrie ca trebuie afisata clasa pentru URL
     --NU EXISTA TEST pentru asta
     --In schimb, exista pentru event-interval
     --desi NU apare in cerinta
     div [class <| isImportant event.important , style "color" "RGB(255,0,255,120)"] [
         h3 [class "event-title"] [ i [] [ text event.title ]]
        ,h3 [class "event-description" ] [ i [] [ event.description ]]
        ,h3 [class "event-category"] [i [] [categoryView event.category]]
        ,h3 [class "event-url"] [i [] [ (event.url)|> eventURL>>text]]
        ,h3 [class "event-interval"] [ Interval.view event.interval ]

     ]
