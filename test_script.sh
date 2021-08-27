#!/bin/sh

flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/app_test.dart -d web-server
flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/app_test_other.dart -d web-server
