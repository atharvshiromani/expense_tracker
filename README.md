# Expensify- A Minimal Expense Tracking Web Application

As per the title of the app, its an expense tracking web application and since the app is developed using Flutter,its very easy to deploy on any platform like iOS, Android, Linux.
# How to run the application
- Web Application has been deployed on the web usin github pages for easier access of the project : https://atharvshiromani.github.io/#/
- For Integration/Unit Test , Chromium WebDriver is used, I have Chrome version 92.0+.(m1 mac) the driver for that version is included in the project folder, if the testing browser is different than mine refer website: 
   - https://chromedriver.chromium.org/downloads based on you platform and platform architechture.
   - run chromium driver on port 4444 by going to the directory with chromium driver file is located using the command:
      - ./chromedriver --port=4444
   - go the project directory and run the following command: 
      - for viewing automated test with GUI: flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/app_test.dart -d web-server --no-headless 
      - for Headless Browser : flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/app_test.dart -d web-server

# Functionality Implemented:
- A Login Page
- A User Expense Tracking Page(Different for each user)
- Real-Time Charts which are updated as new expenses are added.
- Integration Tests with different test cases.
- Unit tests for testing fucntionaity of the different functions implemented.

# Technologies Used:
- Flutter for UI Design
- Language Used: Dart
- Database: Firestone Firebase
- Charts - Syncfusion Package for Flutter


# References:
Big Thanks to all the references that aided in the developement of this project.
- Web App UI inspiration: https://dribbble.com/shots/14666702-Budget-tracker-dashboard-2-0
- For Flutter related development: https://flutter.dev/docs
- For importing new packages and libraries in project: pub.dev
- For Understanding new functionalities and feature set: (Youtube Channel: 1ManStartup) https://www.youtube.com/channel/UC8xcnxN4CyXdPCeUN1eURPg
- For Undersanding Integration Test for flutter: 
   - https://flutter.dev/docs/cookbook/testing/integration/introduction
   - https://morioh.com/p/4f4b95beca00
   - https://stackoverflow.com/
- For Undersanding Unit Test for flutter: 
   - https://flutter.dev/docs/cookbook/testing/unit/introduction
   - https://utkarshkore.medium.com/writing-unit-tests-in-flutter-with-firebase-firestore-72f99be85737

