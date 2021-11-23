module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Json.Decode as De


type alias Repo =
    { name : String
    , description : Maybe String
    , url : String
    , pushedAt : String
    , stars : Int
    }


view : Repo -> Html msg
view repo =
     let
         deconstruct:Maybe String -> String
         deconstruct a=
             case a of
                (Just b )->b
                _->""
     in
     div [class "repo"] [
      h3 [class "repo-name"] [ i [] [ text repo.name ]]
     ,h3[class "repo-description"]  [ text (deconstruct repo.description)]
     ,h3[class "repo-url"] [a [href repo.url] [text repo.url] ]
     ,h3[class "repo-pushedat"] [ i [] [ text repo.pushedAt ]]
     ,h3[class "repo-stars"] [ i [] [ text ( String.fromInt repo.stars )]]
     ]
    --Debug.todo "Implement Model.Repo.view"


sortByStars : List Repo -> List Repo
sortByStars repos =
     (List.sortBy .stars >> List.reverse ) <|repos
    --Debug.todo "Implement Model.Repo.sortByStars"


{-| Deserializes a JSON object to a `Repo`.
Field mapping (JSON -> Elm):

  - name -> name
  - description -> description
  - html\_url -> url
  - pushed\_at -> pushedAt
  - stargazers\_count -> stars

-}
decodeRepo : De.Decoder Repo
decodeRepo =
        De.map5 Repo
            (De.field  "name" De.string)
            (De.maybe (De.field "description" De.string))
            (De.field "html_url" De.string)
            (De.field "pushed_at" De.string)
            (De.field "stargazers_count" De.int)
    --Debug.todo "Implement Model.Repo.decodeRepo"
