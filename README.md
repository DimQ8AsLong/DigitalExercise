# Digital Factory -- Exercise 1

In this exercise I have approched MVC pattern using swift 4. 

Built multiple models as per JSON response in order to ease the way of fetching data.

I did use storyboards in this exercise as it is simple typical master/detailview app.

Also I've used extension for UIImageView to ease the way of downloading picture wether via URL or String.

I've configured Fastlane in order to build project from command line and slather for code coverage.

you can run this code in Terminal to generate test coverage :

slather coverage -s --scheme DigitalExercise ~/PATH/DigitalExercise/DigitalExercise.xcodeproj

you can also build the project using fastlane by typing this line in terminal:

fastlane run xcodebuild

Code is well documented and self explanatory.
