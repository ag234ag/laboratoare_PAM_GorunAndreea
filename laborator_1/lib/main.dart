import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conversie monedă',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const CurrencyConverterPage(),
    );
  }
}

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() =>
      _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController sumaController = TextEditingController();

  String monedaSursa = 'MDL';
  String monedaDestinatie = 'EUR';

  double? rezultat;
  String mesajEroare = '';

  // Cursuri valutare fixe, exprimate în lei moldovenești.
  final Map<String, double> cursuriValutare = {
    'MDL': 1.00,
    'EUR': 19.50,
    'USD': 17.80,
    'RON': 3.90,
    'GBP': 22.70,
  };

  void convertesteMoneda() {
    final String textIntrodus =
        sumaController.text.trim().replaceAll(',', '.');

    final double? suma = double.tryParse(textIntrodus);

    if (suma == null || suma <= 0) {
      setState(() {
        rezultat = null;
        mesajEroare = 'Introduceți o sumă validă mai mare decât zero.';
      });
      return;
    }

    final double cursSursa = cursuriValutare[monedaSursa]!;
    final double cursDestinatie = cursuriValutare[monedaDestinatie]!;

    final double sumaInLei = suma * cursSursa;
    final double sumaConvertita = sumaInLei / cursDestinatie;

    setState(() {
      rezultat = sumaConvertita;
      mesajEroare = '';
    });
  }

  void inverseazaMonedele() {
    setState(() {
      final String monedaTemporara = monedaSursa;
      monedaSursa = monedaDestinatie;
      monedaDestinatie = monedaTemporara;
      rezultat = null;
      mesajEroare = '';
    });
  }

  @override
  void dispose() {
    sumaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator valutar'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.currency_exchange,
              size: 90,
              color: Colors.indigo,
            ),
            const SizedBox(height: 20),
            const Text(
              'Conversie monedă',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Introduceți suma și selectați monedele.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: sumaController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Suma',
                hintText: 'Exemplu: 100',
                prefixIcon: Icon(Icons.payments),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
            key: ValueKey('sursa-$monedaSursa'),
            initialValue: monedaSursa,
              decoration: const InputDecoration(
                labelText: 'Moneda sursă',
                prefixIcon: Icon(Icons.account_balance_wallet),
                border: OutlineInputBorder(),
              ),
              items: cursuriValutare.keys.map((String moneda) {
                return DropdownMenuItem<String>(
                  value: moneda,
                  child: Text(moneda),
                );
              }).toList(),
              onChanged: (String? valoareNoua) {
                if (valoareNoua != null) {
                  setState(() {
                    monedaSursa = valoareNoua;
                    rezultat = null;
                    mesajEroare = '';
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            IconButton(
              onPressed: inverseazaMonedele,
              tooltip: 'Inversează monedele',
              icon: const Icon(
                Icons.swap_vert,
                size: 34,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('destinatie-$monedaDestinatie'),
              initialValue: monedaDestinatie,
              decoration: const InputDecoration(
                labelText: 'Moneda destinație',
                prefixIcon: Icon(Icons.flag),
                border: OutlineInputBorder(),
              ),
              items: cursuriValutare.keys.map((String moneda) {
                return DropdownMenuItem<String>(
                  value: moneda,
                  child: Text(moneda),
                );
              }).toList(),
              onChanged: (String? valoareNoua) {
                if (valoareNoua != null) {
                  setState(() {
                    monedaDestinatie = valoareNoua;
                    rezultat = null;
                    mesajEroare = '';
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: convertesteMoneda,
              icon: const Icon(Icons.calculate),
              label: const Text('CONVERTEȘTE'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (mesajEroare.isNotEmpty)
              Text(
                mesajEroare,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (rezultat != null)
              Card(
                color: Colors.indigo.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Rezultatul conversiei',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${sumaController.text} $monedaSursa = '
                        '${rezultat!.toStringAsFixed(2)} $monedaDestinatie',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 30),
            const Text(
              'Cursuri valutare fixe',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...cursuriValutare.entries.map(
              (element) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '1 ${element.key} = '
                  '${element.value.toStringAsFixed(2)} MDL',
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}