import 'dart:io';

import 'package:fashion_store/data/asset_store_repository.dart';
import 'package:fashion_store/main.dart';
import 'package:fashion_store/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/fake_http.dart';
import '../fakes/memory_asset_bundle.dart';

void main() {
  setUpAll(() => HttpOverrides.global = FakeHttpOverrides());

  for (final width in [390.0, 360.0, 320.0]) {
    testWidgets('real JSON renders without layout errors at $width', (
      tester,
    ) async {
      tester.view
        ..physicalSize = Size(width, 800)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      final repository = AssetStoreRepository(
        bundle: MemoryAssetBundle.fromFile('assets/data/gem_store.json'),
        latency: Duration.zero,
      );

      Future<void> scrollToEnd() async {
        final scrollable = find.byType(Scrollable).first;
        for (var i = 0; i < 6; i++) {
          await tester.drag(scrollable, const Offset(0, -500));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }
      }

      await tester.pumpWidget(GemStoreApp(repository: repository));
      await tester.pumpAndSettle();
      expect(find.text('GemStore'), findsOneWidget);
      expect(find.text('Autumn Collection 2021'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await scrollToEnd();
      expect(find.text('Elegant Design'), findsOneWidget);

      await tester.drag(find.byType(Scrollable).first, const Offset(0, 3000));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'sportwear');
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('Sportwear Set'));
      await tester.pumpAndSettle();
      expect(find.byType(ProductDetailsScreen), findsOneWidget);
      expect(find.text('\$ 80.00'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await scrollToEnd();
      expect(find.text('Kelly Rihanna'), findsOneWidget);
      expect(find.text('Rise Crop Hoodie'), findsOneWidget);
    });
  }
}
