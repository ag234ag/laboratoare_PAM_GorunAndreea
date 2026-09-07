import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laborator_1/main.dart';
import 'package:laborator_1/models/currency.dart';

Future<void> convert(WidgetTester tester) async {
  final button = find.widgetWithText(ElevatedButton, 'Convertește');
  await tester.ensureVisible(button);
  await tester.tap(button);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Interfața principală și conversia cu două zecimale', (
    tester,
  ) async {
    await tester.pumpWidget(const CurrencyConverterApp());
    expect(find.text('Conversie monedă'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(DropdownButton<Currency>), findsNWidgets(2));
    expect(
      find.text('Cursuri fixe · Doar pentru demonstrație'),
      findsOneWidget,
    );
    await tester.enterText(find.byType(TextField), '100,50');
    await convert(tester);
    expect(find.text('5,15 EUR'), findsOneWidget);
    expect(tester.testTextInput.isVisible, isFalse);
    await tester.enterText(find.byType(TextField), '195.00');
    await tester.pump();
    expect(find.text('5,15 EUR'), findsNothing);
    await convert(tester);
    expect(find.text('10,00 EUR'), findsOneWidget);
  });

  testWidgets('Afișează erori clare și permite corectarea sumei', (
    tester,
  ) async {
    await tester.pumpWidget(const CurrencyConverterApp());
    await convert(tester);
    expect(find.text('Introduceți suma de convertit.'), findsOneWidget);
    for (final input in ['0', '-10']) {
      await tester.enterText(find.byType(TextField), input);
      await convert(tester);
      expect(
        find.text('Introduceți o sumă mai mare decât zero.'),
        findsOneWidget,
      );
    }
    await tester.enterText(find.byType(TextField), '12abc');
    await convert(tester);
    expect(
      find.text(
        'Folosiți doar cifre și un singur separator zecimal: virgulă sau punct.',
      ),
      findsOneWidget,
    );
    await tester.enterText(find.byType(TextField), '195');
    await convert(tester);
    expect(find.text('10,00 EUR'), findsOneWidget);
  });

  testWidgets('Inversează și selectează monedele', (tester) async {
    await tester.pumpWidget(const CurrencyConverterApp());
    await tester.enterText(find.byType(TextField), '10');
    await convert(tester);
    await tester.tap(find.byTooltip('Inversează monedele'));
    await tester.pumpAndSettle();
    expect(find.text('Rezultatul va apărea aici.'), findsOneWidget);
    final dropdowns = find.byType(DropdownButton<Currency>);
    expect(
      tester.widget<DropdownButton<Currency>>(dropdowns.first).value,
      Currency.eur,
    );
    expect(
      tester.widget<DropdownButton<Currency>>(dropdowns.last).value,
      Currency.mdl,
    );
    await convert(tester);
    expect(find.text('195,00 MDL'), findsOneWidget);
    await tester.tap(dropdowns.last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('RON · Leu românesc').last);
    await tester.pumpAndSettle();
    expect(find.text('195,00 MDL'), findsNothing);
    await convert(tester);
    expect(find.text('50,00 RON'), findsOneWidget);
  });

  for (final size in [
    const Size(320, 568),
    const Size(800, 360),
    const Size(800, 1280),
  ]) {
    testWidgets('Conversia funcționează la dimensiunea $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const CurrencyConverterApp());
      await tester.enterText(find.byType(TextField), '195');
      await convert(tester);
      await tester.ensureVisible(find.byKey(const Key('conversionResult')));
      expect(find.text('10,00 EUR'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
