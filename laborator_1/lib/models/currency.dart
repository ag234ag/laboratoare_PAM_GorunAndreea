enum Currency {
  mdl('MDL', 'Leu moldovenesc', 1.00),
  eur('EUR', 'Euro', 19.50),
  usd('USD', 'Dolar american', 17.80),
  ron('RON', 'Leu românesc', 3.90),
  gbp('GBP', 'Liră sterlină', 22.70);

  const Currency(this.code, this.label, this.rateInMdl);

  final String code;
  final String label;

  /// Valoarea în MDL a unei unități. Curs fix, exclusiv demonstrativ.
  final double rateInMdl;
}
