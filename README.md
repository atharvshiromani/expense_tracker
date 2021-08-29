# Expensify- A Minimal Expense Tracking Web Application https://atharvshiromani.github.io/#/

As per the title of the app, its an expense tracking web application and since the app is developed using Flutter,its very easy to deploy on any platform like iOS, Android, Linux.
# How to run the application
- This is a flutter based web application, so, flutter needs to be installed on the testing hardware and the program is executed by going to the project directory in the terminal and using the command: 
  - flutter run lib/main.dart, 
- Since it might not be the likely scenario, the Exensify Web Application has been deployed on the web using github pages for easier access of the project : https://atharvshiromani.github.io/#/
- For installing Flutter on the device refer: https://flutter.dev/docs/get-started/install
- For testing purposes, flutter is still needed, A script has been created to run all the integration and test case files from one place. The test script file is named: test_script.sh
- Just in case, I am uploading the screenshot of the test_script.sh file to showcase that all tests have successfully passed(refer image testfiles.png)
- For Integration/Unit Test , Chromium WebDriver is used, Kindly download the web driver based on your browser and platform.
   - https://chromedriver.chromium.org/downloads based on you platform and platform architechture.
   - run chromium driver on port 4444 by going to the directory where chromium driver file is located and using the command:
      - ./chromedriver --port=4444
   - find the project directory and execute the script file using commandd: ./test_script.sh
      

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

