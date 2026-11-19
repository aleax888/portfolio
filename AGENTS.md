# Repository Guidelines

## Project Structure

`lib/main.dart` launches `PortfolioPage`. Edit individual portfolio sections in `lib/pages/sections/` and their content in `lib/domain/`, which holds the project, experience, education, and tech stack enums. For example, to add a project card, update `lib/domain/projects/project_enum.dart` and place its image in `assets/images/projects/`. The enum derives the filename from the display name, so `Led Panel` maps to `led_panel.png`.

Keep page-specific widgets in `lib/pages/widgets/` and reusable layouts, animations, and scroll behaviors in `lib/widgets/`. Use `lib/design_system/` for shared typography, colors, and spacing. Register new asset directories and fonts in `pubspec.yaml`. Browser entry files and app icons live in `web/`.

## Development Commands

Use a Flutter SDK with Dart compatible with `^3.11.4`. Run these commands from the repository root.

| Command | Purpose |
| --- | --- |
| `flutter pub get` | Install the dependencies declared in `pubspec.yaml`. |
| `flutter run -d chrome` | Run the portfolio locally in Chrome. |
| `flutter analyze` | Check Dart code using the configured `flutter_lints` rules. |
| `flutter test` | Run the tests under `test/`. |
| `flutter build web` | Create a release build in `build/web/`. |

## Coding Style

Use two-space indentation and run `dart format` on changed Dart files. Use `lower_snake_case` for filenames, `UpperCamelCase` for types, and `lowerCamelCase` for methods, variables, and enum values.

## Testing

Use `flutter_test` and name test files `*_test.dart`. Run a single file with `flutter test test/widget_test.dart`. That file still exercises Flutter's starter counter. For portfolio changes, use `testWidgets` to check observable behavior, such as whether scrolling brings a section into view. The repository specifies no minimum coverage percentage.

## Commits and Pull Requests

Recent commits use `type(scope): summary`, for example `fix(portfolio-page): handle scroll inputs`. Follow that pattern and describe the change in the imperative. In a pull request, explain the user-visible effect, list the checks you ran, and link any related issue. Include a screenshot for layout changes or a short recording for scrolling and animation changes.
