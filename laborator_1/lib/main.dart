import 'package:flutter/material.dart';

import 'screens/currency_converter_screen.dart';

void main() => runApp(const CurrencyConverterApp());

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Conversie monedă',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 1, 43, 250)),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    ),
    home: const CurrencyConverterScreen(),
  );
}
