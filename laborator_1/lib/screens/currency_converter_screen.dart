// Importă elementele vizuale Flutter.
import 'package:flutter/material.dart';

// Importă modelul valutelor.
import '../models/currency.dart';

// Importă serviciul de conversie.
import '../services/currency_converter.dart';

// Importă lista derulantă pentru valute.
import '../widgets/currency_dropdown.dart';

// Definește ecranul aplicației.
class CurrencyConverterScreen extends StatefulWidget {
  // Constructorul ecranului.
  const CurrencyConverterScreen({super.key});

  // Creează starea ecranului.
  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

// Păstrează și modifică datele ecranului.
class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  // Controlează câmpul pentru sumă.
  final _amountController = TextEditingController();

  // Moneda sursă inițială este MDL.
  Currency _source = Currency.mdl;

  // Moneda destinație inițială este EUR.
  Currency _destination = Currency.eur;

  // Păstrează rezultatul conversiei.
  double? _result;

  // Păstrează mesajul de eroare.
  String? _error;

  // Șterge rezultatul și eroarea.
  void _clearResult() {
    // Elimină rezultatul anterior.
    _result = null;

    // Elimină eroarea anterioară.
    _error = null;
  }

  // Realizează conversia.
  void _convert() {
    // Închide tastatura.
    FocusManager.instance.primaryFocus?.unfocus();

    // Actualizează interfața.
    setState(() {
      // Șterge rezultatul anterior.
      _clearResult();

      // Încearcă efectuarea conversiei.
      try {
        // Salvează rezultatul calculat.
        _result = CurrencyConverter.convert(
          // Transformă textul în număr.
          CurrencyConverter.parseAmount(_amountController.text),

          // Trimite moneda sursă.
          _source,

          // Trimite moneda destinație.
          _destination,
        );

        // Prinde eroarea de format.
      } on FormatException catch (error) {
        // Salvează mesajul erorii.
        _error = error.message;
      }
    });
  }

  // Se execută la închiderea ecranului.
  @override
  void dispose() {
    // Eliberează memoria controllerului.
    _amountController.dispose();

    // Apelează metoda clasei părinte.
    super.dispose();
  }

  // Construiește interfața ecranului.
  @override
  Widget build(BuildContext context) {
    // Preia culorile temei.
    final colors = Theme.of(context).colorScheme;

    // Creează structura paginii.
    return Scaffold(
      // Creează bara de sus.
      appBar: AppBar(
        // Afișează titlul.
        title: const Text('Conversie monedă'),
      ),

      // Creează corpul paginii.
      body: SafeArea(
        // Evită zonele acoperite ale telefonului.
        child: Center(
          // Centrează conținutul.
          child: ConstrainedBox(
            // Limitează lățimea la 600 pixeli.
            constraints: const BoxConstraints(maxWidth: 600),

            // Permite derularea paginii.
            child: SingleChildScrollView(
              // Închide tastatura la derulare.
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,

              // Adaugă spațiu pe margini.
              padding: const EdgeInsets.all(16),

              // Aranjează elementele vertical.
              child: Column(
                // Întinde elementele pe lățime.
                crossAxisAlignment: CrossAxisAlignment.stretch,

                // Conține elementele ecranului.
                children: [
                  // Afișează pictograma valutară.
                  Icon(
                    // Alege pictograma.
                    Icons.currency_exchange,

                    // Stabilește dimensiunea.
                    size: 48,

                    // Aplică culoarea principală.
                    color: colors.primary,
                  ),

                  // Adaugă spațiu vertical.
                  const SizedBox(height: 12),

                  // Afișează titlul principal.
                  Text(
                    // Textul titlului.
                    'Schimb valutar, simplu',

                    // Centrează textul.
                    textAlign: TextAlign.center,

                    // Aplică stilul titlului.
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  // Adaugă spațiu vertical.
                  const SizedBox(height: 8),

                  // Afișează instrucțiunea.
                  const Text(
                    // Textul instrucțiunii.
                    'Introduceți suma și alegeți monedele.',

                    // Centrează textul.
                    textAlign: TextAlign.center,
                  ),

                  // Adaugă spațiu vertical.
                  const SizedBox(height: 20),

                  // Creează cardul formularului.
                  Card(
                    // Adaugă spațiu în card.
                    child: Padding(
                      // Stabilește spațiul interior.
                      padding: const EdgeInsets.all(20),

                      // Aranjează elementele vertical.
                      child: Column(
                        // Întinde elementele pe lățime.
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        // Conține câmpurile formularului.
                        children: [
                          // Creează câmpul pentru sumă.
                          TextField(
                            // Leagă câmpul de controller.
                            controller: _amountController,

                            // Deschide tastatura numerică.
                            keyboardType:
                                const TextInputType.numberWithOptions(
                              // Permite numere zecimale.
                              decimal: true,
                            ),

                            // Afișează butonul Done.
                            textInputAction: TextInputAction.done,

                            // Convertește la apăsarea Done.
                            onSubmitted: (_) => _convert(),

                            // Închide tastatura la apăsare în afară.
                            onTapOutside: (_) =>
                                FocusManager.instance.primaryFocus?.unfocus(),

                            // Șterge rezultatul la modificare.
                            onChanged: (_) => setState(_clearResult),

                            // Configurează aspectul câmpului.
                            decoration: InputDecoration(
                              // Afișează denumirea câmpului.
                              labelText: 'Suma',

                              // Afișează un exemplu.
                              hintText: 'Exemplu: 100,50',

                              // Afișează pictograma banilor.
                              prefixIcon:
                                  const Icon(Icons.payments_outlined),

                              // Afișează eroarea.
                              errorText: _error,

                              // Permite maximum patru rânduri.
                              errorMaxLines: 4,
                            ),
                          ),

                          // Adaugă spațiu vertical.
                          const SizedBox(height: 24),

                          // Creează lista monedei sursă.
                          CurrencyDropdown(
                            // Afișează eticheta listei.
                            label: 'Moneda sursă',

                            // Afișează moneda selectată.
                            value: _source,

                            // Se execută la selectarea monedei.
                            onChanged: (value) => setState(() {
                              // Schimbă moneda sursă.
                              _source = value;

                              // Șterge rezultatul anterior.
                              _clearResult();
                            }),
                          ),

                          // Centrează butonul de inversare.
                          Center(
                            // Creează butonul cu pictogramă.
                            child: IconButton.filledTonal(
                              // Afișează explicația butonului.
                              tooltip: 'Inversează monedele',

                              // Se execută la apăsare.
                              onPressed: () {
                                // Închide tastatura.
                                FocusManager.instance.primaryFocus?.unfocus();

                                // Actualizează ecranul.
                                setState(() {
                                  // Salvează temporar moneda sursă.
                                  final previous = _source;

                                  // Pune destinația ca sursă.
                                  _source = _destination;

                                  // Pune sursa ca destinație.
                                  _destination = previous;

                                  // Șterge rezultatul anterior.
                                  _clearResult();
                                });
                              },

                              // Afișează pictograma de inversare.
                              icon: const Icon(Icons.swap_vert),
                            ),
                          ),

                          // Creează lista monedei destinație.
                          CurrencyDropdown(
                            // Afișează eticheta listei.
                            label: 'Moneda destinație',

                            // Afișează moneda selectată.
                            value: _destination,

                            // Se execută la selectarea monedei.
                            onChanged: (value) => setState(() {
                              // Schimbă moneda destinație.
                              _destination = value;

                              // Șterge rezultatul anterior.
                              _clearResult();
                            }),
                          ),

                          // Adaugă spațiu vertical.
                          const SizedBox(height: 24),

                          // Creează butonul de conversie.
                          ElevatedButton.icon(
                            // Apelează funcția de conversie.
                            onPressed: _convert,

                            // Configurează aspectul butonului.
                            style: ElevatedButton.styleFrom(
                              // Aplică fundalul principal.
                              backgroundColor: colors.primary,

                              // Aplică culoarea textului.
                              foregroundColor: colors.onPrimary,

                              // Mărește înălțimea butonului.
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                            ),

                            // Afișează pictograma calculatorului.
                            icon: const Icon(Icons.calculate_outlined),

                            // Afișează textul butonului.
                            label: const Text('Convertește'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Adaugă spațiu vertical.
                  const SizedBox(height: 12),

                  // Creează cardul rezultatului.
                  Card(
                    // Aplică o culoare cardului.
                    color: colors.primaryContainer,

                    // Adaugă spațiu interior.
                    child: Padding(
                      // Stabilește spațiul interior.
                      padding: const EdgeInsets.all(20),

                      // Aranjează elementele vertical.
                      child: Column(
                        // Conține elementele rezultatului.
                        children: [
                          // Afișează titlul rezultatului.
                          const Text('Rezultatul conversiei'),

                          // Adaugă spațiu vertical.
                          const SizedBox(height: 8),

                          // Ajută cititoarele de ecran.
                          Semantics(
                            // Anunță modificarea rezultatului.
                            liveRegion: true,

                            // Afișează rezultatul.
                            child: Text(
                              // Verifică dacă există rezultat.
                              _result == null

                                  // Mesaj înainte de conversie.
                                  ? 'Rezultatul va apărea aici.'

                                  // Rezultat formatat cu două zecimale.
                                  : '${_result!.toStringAsFixed(2).replaceAll('.', ',')} ${_destination.code}',

                              // Identifică rezultatul în teste.
                              key: const Key('conversionResult'),

                              // Centrează rezultatul.
                              textAlign: TextAlign.center,

                              // Aplică stilul rezultatului.
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    // Aplică culoarea textului.
                                    color: colors.onPrimaryContainer,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Adaugă spațiu vertical.
                  const SizedBox(height: 20),

                  // Afișează titlul cursurilor.
                  const Text(
                    // Textul secțiunii.
                    'Cursuri valutare',

                    // Scrie textul îngroșat.
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  // Adaugă spațiu vertical.
                  const SizedBox(height: 12),

                  // Afișează cursurile pe mai multe rânduri.
                  Wrap(
                    // Adaugă spațiu orizontal.
                    spacing: 8,

                    // Adaugă spațiu vertical.
                    runSpacing: 4,

                    // Creează lista cursurilor.
                    children: Currency.values
                        // Parcurge toate valutele.
                        .map(
                          // Creează o etichetă pentru fiecare valută.
                          (currency) => Chip(
                            // Afișează cursul valutar.
                            label: Text(
                              // Formatează cursul în MDL.
                              '1 ${currency.code} = ${currency.rateInMdl.toStringAsFixed(2).replaceAll('.', ',')} MDL',
                            ),
                          ),
                        )

                        // Transformă rezultatele într-o listă.
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}