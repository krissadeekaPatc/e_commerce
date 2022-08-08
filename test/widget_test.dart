import 'dart:ui';

import 'package:e_commerce_app/constant_key/home_page.dart';
import 'package:e_commerce_app/presentations/complete_page/complete_page.dart';
import 'package:e_commerce_app/presentations/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Widget createWidgetForTesting(
      {required Widget child, List<NavigatorObserver>? mockObserver}) {
    return MaterialApp(
      home: child,
      navigatorObservers: mockObserver ?? [],
    );
  }

  group('End to end', () {
    late NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    testWidgets("Home Page", (tester) async {
      // app.main();
      // await tester.pumpWidget(const CompletePage());
      await mockNetworkImages(() async {
        await tester.pumpWidget(createWidgetForTesting(
          child: const HomePage(),
          mockObserver: [mockObserver],
        ));
        await tester.pumpAndSettle();
        expect(find.text('E - Commerce'), findsOneWidget);
        expect(find.text('E - Commerce'), findsOneWidget);
        expect(find.text('E - Commerce'), findsOneWidget);
        expect(find.text('E - Commerce'), findsOneWidget);
        // verify(mockObserver.didPush(any!, any));
      });

      final Finder button = find.byKey(
        Key(HomePageConstantKey.productListKey + "1"),
      );

      await tester.tap(button);

      // Verify the counter increments by 1.
      // expect(find.text('1'), findsOneWidget);
    });
  });

  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {

  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
}
