# Favorite Books App
This project consists of 4 main pages: the homepage, search page, my favorite books page, and book categories page, developed using the Google Books API. During the development process of the project, the MVVM architecture and Provider State Management method were utilized.
A new Flutter project.

## The Libraries and Technologies
- MVVM (Model-View-ViewModel) Architecture: A software architectural pattern that separates the application's data (model), user interface (view), and logic (view model) components to ensure separation of concerns and maintainability. (https://learn.microsoft.com/en-us/dotnet/architecture/maui/mvvm)
- Google Books API: An API provided by Google that allows access to a vast collection of books and related information. (https://developers.google.com/books/docs/v1/using)
- mobx => https://pub.dev/packages/mobx
- flutter_mobx => https://pub.dev/packages/flutter_mobx
- provider => https://pub.dev/packages/provider
- mobx_codegen => https://pub.dev/packages/mobx_codegen
- build_runner => https://pub.dev/packages/build_runner
- flutter_svg => https://pub.dev/packages/flutter_svg
- auto_size_text => https://pub.dev/packages/auto_size_text
- http => https://pub.dev/packages/http

## Application Pages
### Onboard
- The application includes three introductory screens that provide brief descriptions and visuals about the app.

<table>
  <tr>
    <td>Onboard Page One</td>
    <td>Onboard Page Two</td>
    <td>Onboard Page Three</td> 
  </tr>  
  <tr>
    <td><img src="github/screenshots/onboard-1.png" width=270 height=480></td>
    <td><img src="github/screenshots/onboard-2.png" width=270 height=480></td>
     <td><img src="github/screenshots/onboard-3.png" width=270 height=480></td>
  </tr>
</table>

### Home Page
- The introductory screens welcome the user with a combination of images and written headlines. Underneath the headlines, there are lists of trending and best-selling books. When clicked on any book in these lists, the user can transition to a detailed page that provides descriptions and information about the book.

<table>
  <tr>
    <td>Home Page</td>
  
  </tr>  
  <tr>
    <td><img src="github/screenshots/book-home.png" width=270 height=480></td>
  
  </tr>
</table>
