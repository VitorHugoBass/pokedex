import 'dart:ui';

import 'package:catalogo/configs/types.dart';
import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import 'ofensores_props.dart';
import 'tipos_ofensor.dart';

class Ofensor {
  final int id;
  final String name;
  final String description;
  final String category;
  final String tipo;
  final String image;
  final List<Image> images;
  final OfensorFase fase;
  final OfensorFaseDuracaoDias tempoDuracaoFase;
  final List<Ofensor> evolucao;
  final Color color;

  const Ofensor(
      @required this.id,
      @required this.name,
      this.description,
      this.category,
      this.tipo,
      @required this.image,
      this.images,
      this.fase,
      this.tempoDuracaoFase,
      this.evolucao,
      this.color);
}
