module PackagingUnit exposing (PackagingUnit(..), toString)


type PackagingUnit
    = Quantity
    | Gram
    | Liter
    | Milliliter
    | Can


toString : PackagingUnit -> Int -> String
toString unit n =
    case unit of
        Quantity ->
            String.fromInt n ++ " x"

        Gram ->
            String.fromInt n ++ " g"

        Liter ->
            String.fromInt n ++ " l"

        Milliliter ->
            String.fromInt n ++ " ml"

        Can ->
            let
                str =
                    if n == 1 then
                        " Dose"

                    else
                        " Dosen"
            in
            String.fromInt n ++ str
