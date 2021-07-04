# movieDbApp

Small Mobile Project assignment to retrieve movies from The Movie Database API. Application developed in Xcode 9.4 without CocoaPods because of OS (Sierra 10.12.6) compatibility issues. My MacBook Pro was broken and the backup was way too old.

App layers
  -
**1. UI:** Custom UI elements used across the app.

  * _MovieCell_: Custom cell for displaying movies list. 
  * _LoadingCell_: Custom cell for showing loading on the infinite scroll of the movies lists.

    Both classes work for Upcoming, Popular & TopRated Movies list.

**2. Model:** Structure for the objects handle inside the app.

  * _Movie_: Structure for Movie and Movie Details information retrieved from the API. Handle de decode from JSON to the object attributes.
  * _Video_: Structure for Video information retrieved from the API. Handle de decode from JSON to the object attribute. It only has key as an attribute but the class was created to allow the feature to grow in the future.

**3. Network:** Layer on the charge of handle network requests to the API. I used this [framework](https://github.com/malcolmkmd/NetworkLayer/tree/master/NetworkLayer) inside the code because of the Cocoa issues described above.
  
  - Network Layer Framework
    - Framework classes
     - Response, Service, Endpoint & Encoding modules were not changed. The intention of adding this framework was to avoid using a custom implementation of Network requests to focus on the main features of the app.
    
    - Modified classes
     - MovieEndPoint: Changes were to add base URL, paths, HTTP tasks, and add v4 authorization header.
     - NetworkManager: Add getMovieDetail and getVideo requests and change the getMovies request.  
  
  - Own classes
  - Video Response: Handle the response of getting a movie video request.

      I did not change or removed the NetworkLogger because it was on the framework implementation. But I will not use it inside an app due to security reasons. It is not secure leaving logs of request information and retrieve data outside of the development environment.

**4. Modules:** Layer on the charge of the app features with business logic. The features are Upcoming, Popular & TopRated Movies, and Movie Details, including Play Video. I developed the app using the MVP pattern due to the size of the app and testing reasons. The MVP pattern works perfectly to distribute the responsibilities of the app with no complex UI interfaces and allow a proper way to realize Unit Testing.

   - _Video_
     - VideoContract: MVP protocol for View and Presenter in the video feature.
     - PlayVideoViewController: Follows VideoContract for View and UI events of Play Video feature.
     - PlayVideoPresenter: Follows VideoContract for Presenter and handles the business logic and retrieves information for Play Video feature.
  - _MovieDetail_
    - MovieDetailContract: MVP protocol for View and Presenter in the Movie Detail feature.
    - MovieDetailViewController: Follows MovieDetailContract for View and UI events of Movie Detail feature.
    - MovieDetailsPresenter: Follows MovieDetailContract for Presenter and handles the business logic and retrieves information for Movie Detail feature.
  - _Common_ 
    - MoviesContract: MVP protocol for View and Presenter in the Movies feature. I designed it to work for the three categories.
    - MoviesViewController: Follows MoviesContract for View and UI events of Movie feature.
    - MoviesAppPresenter: Follows MoviesContract for Presenter and handles the business logic and retrieves information for Movie feature.
  - _Upcoming_
    - UpcomingViewController: Child of MoviesViewController with special handling for Upcoming category.
    - UpcomingPresenter: Child of MoviesAppPresenter with special handling for Upcoming category.
  - _Popular_
    - PopularViewController: Child of MoviesViewController with special handling for Popular category.
    - PopularPresenter: Child of MoviesAppPresenter with special handling for Popular category.
  - _TopRated_
    - TopRatedViewController: Child of MoviesViewController with special handling for TopRated category.
    - TopRatedPresenter: Child of MoviesAppPresenter with special handling for TopRated category.

Assignment Questions
  -

**1. What is the principle of single responsibility? What is its purpose?**
The single responsibility principle is a good design and coding practice that use one class or object for just one and single responsibility. The main purpose of this principle is to distribute the responsibilities so the code in the project is not dependant on each other to accomplish one responsibility. Each class will have its responsibility and it will not depend on others to reach it. 

This technique helps to keep a good architecture, design, and code inside the project. Also helps to understand the code and make tests for the project. All of these benefits will make the project easy to read and maintain.


**2. What characteristics does a "good" code or clean code have, in your opinion?**
In my opinion, a good or clean code should follow these rules:

1. _Single responsibility principle:_ Explained above.
2. _Avoid your code are dependant on one framework:_ Try to use your business logic classes separate from framework dependency and avoid using framework-related objects. In mobile, this is a little bit different but if you leave your business logic separate from your UI you can refactor or remake one piece without affecting the other one.
3. _TDD (or UnitTesting at least):_ The TDD is a great way to develop because we only code what is required. TDD saves you hours of coding but also helps you to keep the project safer from bugs. If the project, team, or business does not work with TDD at least a good unit test during the development process could make a great difference.
4. _Good practices (Follow standards, good classes, and method naming, using repositories, code reviews):_ A good process of development will always produce good results. Be aligned with the standards and good practices will keep the project easy for Seniors and Juniors. Regarding the Code review process, it helps developers to grow and learn from each other, which should be a must.
5. _Using Design Patterns_
6. _Use the right architectural pattern for the app (MVC, MVP, MVVM, VIPER):_ There are a lot of options and all of them are good in the right context so we need to analyze what is better for the project and use it wisely.
7. _Good layer organization:_ Order is never a bad thing, if you keep the classes in the module and layer they belong it will be easier to read, understand, test, and troubleshoot the project.
8. _Put Comments:_ Sometimes it feels weird to add comments to simple functions inside the code but it will never hurt. Having good code documentation could save hours of troubleshooting or keep tracking of a feature. Of course, it should be a balance, we do not need a long explanation but a concise description would work.

All of these items help keep a project cleaner and better. I think we as developers need to change our mindset to one that knows we need to develop things that other developers should understand and maintain. With kind of thinking, we will write better code, and will be easier for us to keep the project in a good shape.
