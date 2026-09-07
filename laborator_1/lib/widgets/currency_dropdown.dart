import 'package:flutter/material.dart';

import '../models/currency.dart';

class CurrencyDropdown extends StatelessWidget {
  const CurrencyDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final Currency value;
  final ValueChanged<Currency> onChanged;

  @override
  Widget build(BuildContext context) => InputDecorator(
    decoration: InputDecoration(labelText: label),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<Currency>(
        value: value,
        isExpanded: true,
        isDense: true,
        items: Currency.values
            .map(
              (currency) => DropdownMenuItem(
                value: currency,
                child: Text(
                  '${currency.code} · ${currency.label}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        onChanged: (currency) {
          if (currency != null) {
            FocusManager.instance.primaryFocus?.unfocus();
            onChanged(currency);
          }
        },
      ),
    ),
  );
}
