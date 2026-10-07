import 'dart:io';

import 'package:fashion_store/data/store_repository.dart';
import 'package:fashion_store/main.dart';
import 'package:fashion_store/screens/catalog_screen.dart';
import 'package:fashion_store/screens/product_details_screen.dart';
import 'package:fashion_store/widgets/state_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/fake_http.dart';
import '../fakes/fake_store_repository.dart';

void main() {
  setUpAll(() => HttpOverrides.global = FakeHttpOverrides());

  void useScreen(WidgetTester tester, double width) {
    tester.view
      ..physicalSize = Size(width, 844)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  for (final width in [390.0, 320.0]) {
    testWidgets('at $width: home, catalog search and filters, details', (
      tester,
    ) async {
      useScreen(tester, width);
      await tester.pumpWidget(GemStoreApp(repository: FakeStoreRepository()));
      expect(find.byType(LoadingView), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.text('GemStore'), findsOneWidget);
      expect(find.text('Turtleneck Sweater'), findsOneWidget);
      expect(find.text('\$ 39.99'), findsOneWidget);

      await tester.tap(find.text('Show all').first);
      await tester.pumpAndSettle();
      expect(find.byType(CatalogScreen), findsOneWidget);
      expect(find.text('Long Sleeve Dress'), findsOneWidget);
      expect(find.text('White Hoodie'), findsNothing);

      await tester.tap(find.text('All'));
      await tester.pumpAndSettle();
      expect(find.text('White Hoodie'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'xyz');
      await tester.pumpAndSettle();
      expect(find.text('No matching products'), findsOneWidget);

      await tester.tap(find.text('Clear filters'));
      await tester.pumpAndSettle();
      expect(find.text('Gym Crop Top'), findsOneWidget);

      await tester.tap(find.byTooltip('Add to favorites').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      expect(find.byTooltip('Remove from favorites'), findsOneWidget);

      await tester.tap(find.text('Turtleneck Sweater'));
      await tester.pumpAndSettle();
      expect(find.byType(ProductDetailsScreen), findsOneWidget);
      expect(find.text('Warm and soft.'), findsOneWidget);

      await tester.tap(find.text('Add To Cart'));
      await tester.pump();
      expect(find.textContaining('added to cart'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('home shows Error and recovers on retry', (tester) async {
    useScreen(tester, 390);
    final repository = FakeStoreRepository(
      error: const StoreDataException('Store data is not valid JSON'),
    );
    await tester.pumpWidget(GemStoreApp(repository: repository));
    await tester.pumpAndSettle();
    expect(find.text('Could not load data'), findsOneWidget);
    expect(find.text('Store data is not valid JSON'), findsOneWidget);

    repository.error = null;
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text('Turtleneck Sweater'), findsOneWidget);
  });

  testWidgets('home shows Empty state without products', (tester) async {
    await tester.pumpWidget(
      GemStoreApp(
        repository: FakeStoreRepository(
          home: sampleHome(featured: const [], recommended: const []),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('No products yet'), findsOneWidget);
  });
}
