import 'package:news_app/config/colors.dart';
import 'package:news_app/models/categories2.dart';
import '../routes.dart';

const List<Category> categories = [
  Category(name: 'VTop', color: AppColors.teal, route: Routes.bookmarks),
  Category(
      name: 'Faculty Search', color: AppColors.red, route: Routes.searchpage),
  Category(
      name: 'Exam Portal', color: AppColors.blue, route: Routes.searchpage),
  Category(name: 'Library', color: AppColors.yellow, route: Routes.searchpage),
  Category(
      name: 'Academic Calender',
      color: AppColors.purple,
      route: Routes.bookmarks),
  Category(
      name: 'Type Effects', color: AppColors.brown, route: Routes.searchpage),
];
