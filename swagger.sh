rm -r MarvelApp/swagger/Marvel
SwagGen generate marvel.yaml --destination MarvelApp/swagger/Marvel --option name:MarvelClient
pod install