#!/bin/sh

flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/app_test.dart -d web-server
flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/app_incorrectsignin.dart -d web-server
flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/signup_test.dart -d web-server
flutter test test/authentication_unit_test.dart
