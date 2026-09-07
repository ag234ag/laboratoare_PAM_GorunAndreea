import 'package:flutter/material.dart';

import '../models/currency.dart';
import '../services/currency_converter.dart';
import '../widgets/currency_dropdown.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final _amountController = TextEditingController();
  Currency _source = Currency.mdl;
  Currency _destination = Currency.eur;
  double? _result;
  String? _error;

  void _clearResult() {
    _result = null;
    _error = null;
  }

  void _convert() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _clearResult();
      try {
        _result = CurrencyConverter.convert(
          CurrencyConverter.parseAmount(_amountController.text),
          _source,
          _destination,
        );
      } on FormatException catch (error) {
        _error = error.message;
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Conversie monedă')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.currency_exchange,
                    size: 48,
                    color: colors.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Schimb valutar, simplu',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Introduceți suma și alegeți monedele.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _convert(),
                            onTapOutside: (_) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                            onChanged: (_) => setState(_clearResult),
                            decoration: InputDecoration(
                              labelText: 'Suma',
                              hintText: 'Exemplu: 100,50',
                              prefixIcon: const Icon(Icons.payments_outlined),
                              errorText: _error,
                              errorMaxLines: 4,
                            ),
                          ),
                          const SizedBox(height: 24),
                          CurrencyDropdown(
                            label: 'Moneda sursă',
                            value: _source,
                            onChanged: (value) => setState(() {
                              _source = value;
                              _clearResult();
                            }),
                          ),
                          Center(
                            child: IconButton.filledTonal(
                              tooltip: 'Inversează monedele',
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                setState(() {
                                  final previous = _source;
                                  _source = _destination;
                                  _destination = previous;
                                  _clearResult();
                                });
                              },
                              icon: const Icon(Icons.swap_vert),
                            ),
                          ),
                          CurrencyDropdown(
                            label: 'Moneda destinație',
                            value: _destination,
                            onChanged: (value) => setState(() {
                              _destination = value;
                              _clearResult();
                            }),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: _convert,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primary,
                              foregroundColor: colors.onPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            icon: const Icon(Icons.calculate_outlined),
                            label: const Text('Convertește'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    color: colors.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text('Rezultatul conversiei'),
                          const SizedBox(height: 8),
                          Semantics(
                            liveRegion: true,
                            child: Text(
                              _result == null
                                  ? 'Rezultatul va apărea aici.'
                                  : '${_result!.toStringAsFixed(2).replaceAll('.', ',')} ${_destination.code}',
                              key: const Key('conversionResult'),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(color: colors.onPrimaryContainer),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Cursuri valutare',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: Currency.values
                        .map(
                          (currency) => Chip(
                            label: Text(
                              '1 ${currency.code} = ${currency.rateInMdl.toStringAsFixed(2).replaceAll('.', ',')} MDL',
                            ),
                          ),
                        )
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
