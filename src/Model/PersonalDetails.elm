module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, href, id, style)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }
view : PersonalDetails -> Html msg
view details =
    let
        getCD contactDetails = List.map (\x ->  li [class "contact-detail"] [text x.detail]) contactDetails
        getS socialLinks = List.map (\x ->  li [class "social-link"] [a [href x.detail] [text x.name] ] ) socialLinks
    in
    div [style "color" "RGB(255,0,255,120)"]  [ h1 [id "name"] [ i [] [ text details.name ]]
               , em [id "intro" ] [ i [] [ text details.intro ]]
               , ul [] (getCD details.contacts )
               , ul [] (getS details.socials )
        ]
    --Debug.todo "Implement the Model.PersonalDetails.view function"
