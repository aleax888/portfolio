import 'dart:ui';

mixin TechStackItem {
  String get fileName;
  String get image => 'assets/images/logos/tech_stack/$fileName';
  String get name;
  String get description;
  Color get color;
}
