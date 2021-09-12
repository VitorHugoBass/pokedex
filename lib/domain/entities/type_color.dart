import 'package:catalogo/configs/types.dart';
import 'package:flutter/material.dart';
import 'package:catalogo/configs/colors.dart';
import 'package:catalogo/domain/entities/tipos_ofensor.dart';

Color colorGenerator(TiposOfensor val) {
  switch (val) {
    case TiposOfensor.praga:
      return AppColors.lightTeal;

    case TiposOfensor.doenca:
      return AppColors.lightRed;

    case TiposOfensor.fungo:
      return AppColors.lightBlue;

    default:
      return AppColors.lightBlue;
  }
}
