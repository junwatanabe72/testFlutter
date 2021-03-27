// Imports the Flutter Driver API.
// import 'package:flutter_driver/flutter_driver.dart';
// import 'package:test/test.dart';

// void main() {
//   group('Counter App', () {
//     // First, define the Finders and use them to locate widgets from the
//     // test suite. Note: the Strings provided to the `byValueKey` method must
//     // be the same as the Strings we used for the Keys in step 1.
//     final counterTextFinder = find.byValueKey('counter');
//     final buttonFinder = find.byValueKey('increment');

//     FlutterDriver driver;

//     // Connect to the Flutter driver before running any tests.
//     setUpAll(() async {
//       driver = await FlutterDriver.connect();
//     });

//     // Close the connection to the driver after the tests have completed.
//     tearDownAll(() async {
//       if (driver != null) {
//         driver.close();
//       }
//     });

//     test('starts at 0', () async {
//       // Use the `driver.getText` method to verify the counter starts at 0.
//       expect(await driver.getText(counterTextFinder), "0");
//     });

//     test('increments the counter', () async {
//       // First, tap the button.
//       await driver.tap(buttonFinder);

//       // Then, verify the counter text is incremented by 1.
//       expect(await driver.getText(counterTextFinder), "1");
//     });
//   });
// }

// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Scrollable App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('verifies the list contains a specific item', () async {
      // Create two SerializableFinders and use these to locate specific
      // widgets displayed by the app. The names provided to the byValueKey
      // method correspond to the Keys provided to the widgets in step 1.
      final listFinder = find.byValueKey('long_list');
      final itemFinder = find.byValueKey('item_50_text');

      final timeline = await driver.traceAction(() async {
        await driver.scrollUntilVisible(
          listFinder,
          itemFinder,
          dyScroll: -300.0,
        );

        expect(await driver.getText(itemFinder), 'Item 50');
      });
      // Convert the Timeline into a TimelineSummary that's easier to
      // read and understand.
      final summary = new TimelineSummary.summarize(timeline);

      // Then, save the summary to disk.
      await summary.writeSummaryToFile('scrolling_summary', pretty: true);

      // Optionally, write the entire timeline to disk in a json format.
      // This file can be opened in the Chrome browser's tracing tools
      // found by navigating to chrome://tracing.
      await summary.writeTimelineToFile('scrolling_timeline', pretty: true);
    });
  });
}
