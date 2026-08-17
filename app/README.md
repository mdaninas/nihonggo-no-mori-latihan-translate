# Nihongo no Mori

A Flutter app for practising Japanese readings from the nine supplied JLPT N3 question photos (pages 58–66).

## Included content

- 9 source photos in `assets/questions/`
- 90 structured, individual multiple-choice questions in `lib/data/questions.dart`
- Transcribed answer keys from the printed `正答` rows
- Indonesian translations and displayable ruby/furigana for every tested word
- Photo viewer with pinch-to-zoom and pan
- Independent Furigana and Indonesian translation toggles
- In-memory progress for the active app session

## Run

From this folder:

```sh
flutter pub get
flutter test
flutter run
```

If this folder was copied without its platform runners, generate the standard
Android and iOS runners once (this does not change the app code or assets):

```sh
flutter create . --platforms=android,ios
```

The project intentionally uses only Flutter SDK widgets—`InteractiveViewer` provides image zoom—so it has no third-party runtime dependencies.
