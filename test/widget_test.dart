import 'dart:ui';

import 'package:e_commerce_app/constant_key/address_selection_page.dart';
import 'package:e_commerce_app/constant_key/complete_page.dart';
import 'package:e_commerce_app/constant_key/detail_page.dart';
import 'package:e_commerce_app/constant_key/home_page.dart';
import 'package:e_commerce_app/constant_key/payment_selection_page.dart';
import 'package:e_commerce_app/presentations/address_selection_page/addres_selection_page.dart';
import 'package:e_commerce_app/presentations/complete_page/complete_page.dart';
import 'package:e_commerce_app/presentations/detail_page/detail_page_screen.dart';
import 'package:e_commerce_app/presentations/home_page/home_page.dart';
import 'package:e_commerce_app/presentations/payment_selection_page/payment_selection_page.dart';
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

        for (var i = 0; i <= 5; i++) {
          expect(find.byKey(Key(HomePageConstantKey.filterButtonKey + "$i")),
              findsWidgets);
          Finder button =
              find.byKey(Key(HomePageConstantKey.filterButtonKey + "$i"));
          await tester.tap(button);
        }

        expect(
            find.byKey(Key(HomePageConstantKey.cartButtonKey)), findsWidgets);

        for (var i = 0; i < 25; i++) {
          expect(find.byKey(Key(HomePageConstantKey.productListKey + "$i")),
              findsWidgets);
        }
      });
    });
    testWidgets("Payment Selection Page", (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(createWidgetForTesting(
          child: const PaymentSelectionPage(),
          mockObserver: [mockObserver],
        ));
        await tester.pumpAndSettle();
        expect(
            find.byKey(
                Key(PaymentSelectionPageConstantKey.paymentListKey + "0")),
            findsWidgets);
        expect(
            find.byKey(Key(PaymentSelectionPageConstantKey.checkOutButtonKey)),
            findsWidgets);
        expect(
            find.byKey(
                Key(PaymentSelectionPageConstantKey.addNewPaymentButtonKey)),
            findsWidgets);
      });
    });

    testWidgets("Address Selection Page", (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(createWidgetForTesting(
          child: const AddressSelectionPage(),
          mockObserver: [mockObserver],
        ));
        await tester.pumpAndSettle();
        expect(
            find.byKey(
                Key(AddressSelectionPageConstantKey.addressListKey + "0")),
            findsWidgets);
        expect(
            find.byKey(
                Key(AddressSelectionPageConstantKey.continuePaymentButtonKey)),
            findsWidgets);
        expect(
            find.byKey(
                Key(AddressSelectionPageConstantKey.addNewAddressButtonKey)),
            findsWidgets);
      });
    });

    testWidgets("Complete Page", (tester) async {
      // app.main();
      // await tester.pumpWidget(const CompletePage());
      await mockNetworkImages(() async {
        await tester.pumpWidget(createWidgetForTesting(
          child: const CompletePage(),
          mockObserver: [mockObserver],
        ));
        await tester.pumpAndSettle();
        expect(
            find.byKey(Key(CompletePageConstantKey.titleKey)), findsOneWidget);
        expect(
            find.byKey(Key(CompletePageConstantKey.iconKey)), findsOneWidget);
      });
    });
  });
}
