import 'package:flutter_test/flutter_test.dart';
import 'package:laborator_1/main.dart';

void main() {
  testWidgets('Aplicația afișează interfața de conversie',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CurrencyConverterApp());

    expect(find.text('Conversie monedă'), findsOneWidget);
    expect(find.text('CONVERTEȘTE'), findsOneWidget);
    expect(find.text('Moneda sursă'), findsOneWidget);
    expect(find.text('Moneda destinație'), findsOneWidget);
  });
}