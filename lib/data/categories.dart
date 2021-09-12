import 'package:catalogo/configs/colors.dart';
import 'package:catalogo/domain/entities/category.dart';
import 'package:catalogo/routes.dart';

const List<Category> categories = [
  Category(name: 'Catalogo', color: AppColors.teal, route: Routes.catalogo),
  Category(name: 'Moves', color: AppColors.red, route: Routes.catalogo),
  Category(name: 'Abilities', color: AppColors.blue, route: Routes.catalogo),
  Category(name: 'Items', color: AppColors.yellow, route: Routes.catalogo),
  Category(name: 'Locations', color: AppColors.purple, route: Routes.catalogo),
  Category(name: 'Type Effects', color: AppColors.brown, route: Routes.typeEffects),
];
