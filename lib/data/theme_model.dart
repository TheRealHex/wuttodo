import 'package:hive/hive.dart';

part 'theme_model.g.dart';

@HiveType(typeId: 2)
class ThemeModel extends HiveObject {
  @HiveField(0)
  bool isDark;

  ThemeModel({required this.isDark});
}
