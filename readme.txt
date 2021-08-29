Expensify- A Minimal Expense Tracking Web Application
As per the title of the app, its an expense tracking web application and since the app is developed using Flutter,its very easy to deploy on any platform like iOS, Android, Linux.

How to run the application
    1). This is a flutter based web application, so, flutter needs to be installed on the testing hardware and the program is executed by going to the project directory in the terminal and using the command:
        flutter run lib/main.dart,
    2). Since it might not be the likely scenario, the Exensify Web Application has been deployed on the web using github pages for easier access of the project : https://atharvshiromani.github.io/#/
    3). For installing Flutter on the device refer: https://flutter.dev/docs/get-started/install
    4). For testing purposes, flutter is still needed, A script has been created to run all the integration and test case files from one place. The test script file is named: test_script.sh
    5). Just in case, I am uploading the screenshot of the test_script.sh file to showcase that all tests have successfully passed(refer image testfiles.png)
    6). For Integration/Unit Test , Chromium WebDriver is used, Kindly download the web driver based on your browser and platform.
        https://chromedriver.chromium.org/downloads based on you platform and platform architechture.
    7). Run chromium driver on port 4444 by going to the directory where chromium driver file is located and using the command:
        ./chromedriver --port=4444
    8).find the project directory and execute the script file using commandd: ./test_script.sh
    
Functionality Implemented:
1). A Login Page
2). A User Expense Tracking Page(Different for each user)
3). Real-Time Charts which are updated as new expenses are added.
4). Integration Tests with different test cases.
5). Unit tests for testing fucntionaity of the different functions implemented.

Technologies Used:

Flutter for UI Design
Language Used: Dart
Database: Firestone Firebase
Charts - Syncfusion Package for Flutter

References:
Big Thanks to all the references that aided in the developement of this project.

1). Web App UI inspiration: https://dribbble.com/shots/14666702-Budget-tracker-dashboard-2-0
2). For Flutter related development: https://flutter.dev/docs
3). For importing new packages and libraries in project: pub.dev
4). For Understanding new functionalities and feature set: (Youtube Channel: 1ManStartup) https://www.youtube.com/channel/UC8xcnxN4CyXdPCeUN1eURPg
5). For Undersanding Integration Test for flutter:
        https://flutter.dev/docs/cookbook/testing/integration/introduction
        https://morioh.com/p/4f4b95beca00
        https://stackoverflow.com/
6).For Undersanding Unit Test for flutter:
        https://flutter.dev/docs/cookbook/testing/unit/introduction
        https://utkarshkore.medium.com/writing-unit-tests-in-flutter-with-firebase-firestore-72f99be85737
        www.stackoverflow.com/
