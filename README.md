<h1 align="center">Marvel App</h1>

*Author:* Carlos Rodriguez Asensio


## Requirements
- Xcode 13.2.1
- Swift 5.0

## Objective
- This is a simple project capable to show a Marvel characters list and their details using MVVM architecture, reactive programming and unit testing. The app uses the Marvel API (https://developers.marvel.com/docs).
 
## Installation
- Run the `pod install` command
- Clean and build the project in Xcode

## 3rd-Party Libraries
 - **RxSwift/RxCocoa** - to make reactive binding of API call and response.

## Design pattern
 - **MVVM** - means Model, View, ViewModel. Also, util classes are used like Router or NetworkManager.
 
    - *Model* - defines the API response data.
    - *View* - created with .xib and UIViewController, configures UI.
    - *ViewModel* - business logic, gets the data from service and injects it to the view.
    
    - *Router* - creates and instances the view through the SceneDelegate.
    - *NetworkManager* - responsible for making API calls.
    - *RequestHandler* - responsible for creating service URL.
    
    - *Constants* - app useful data. In this case, especially in order to generate the URL.
    - *Tests* - all the files needed to make model and network Unit Testing.
 
 ## Potential improvements
- More information in the detail view.
- Add other kind of lists from service, like 'Comics' or 'Creators'.
- Create our custom lists, selecting our favourite characters.
- Improve the app UI/UX. Add some animations.
- Improve the app Unit Tests and implement UI and Integration Tests.
- Add more languages to the app.
- Create a struct named Optionals in the Constants file to create a URL for making a more refined search.
- Handle error in the NetworkManager (Showing alert. Actually, just printing message).

