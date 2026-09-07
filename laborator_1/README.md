# Conversie monedă

Aplicație Flutter exclusiv pentru Android, cu interfață Material 3 în română.
Nu necesită internet sau pachete externe pentru conversie.

Cursuri fixe demonstrative: MDL = 1, EUR = 19,50, USD = 17,80,
RON = 3,90 și GBP = 22,70 MDL pentru o unitate.
Formula: `suma × cursSursă / cursDestinație`.
Suma trebuie să fie pozitivă; se acceptă virgulă sau punct zecimal.
Rezultatele sunt afișate cu două zecimale. Cursurile nu sunt cursuri live.

## Structură

- `lib/main.dart`: aplicație și temă.
- `lib/models/currency.dart`: monede și cursuri în MDL.
- `lib/services/currency_converter.dart`: validare și calcul.
- `lib/screens/currency_converter_screen.dart`: interfață și stare.
- `lib/widgets/currency_dropdown.dart`: selector reutilizabil.
- `test/`: teste de logică și interfață, inclusiv ecrane de dimensiuni diferite.

## Rulare pe Android

Instalați Flutter și Android SDK. Porniți un emulator din Android Studio
(Device Manager) sau conectați un telefon prin USB, activați opțiunile pentru
dezvoltatori și depanarea USB, apoi acceptați autorizarea pe telefon.
Din directorul proiectului:

```sh
flutter pub get
flutter devices
flutter run -d <id_dispozitiv_android>
```

## Verificări

```sh
flutter pub get
dart format .
flutter analyze
flutter test
```

Singura modificare manuală în Android este eticheta aplicației din manifest,
pentru afișarea numelui „Conversie monedă” pe telefon.
