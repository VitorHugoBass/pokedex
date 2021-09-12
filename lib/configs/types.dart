import 'package:flutter/material.dart';
import 'package:catalogo/domain/entities/tipos_ofensor.dart';

class TipoOfensor {
  const TipoOfensor({
    @required this.tipo,
    @required this.nome,
    @required this.plantaDano,
    @required this.color,
  });
  final TiposOfensor tipo;
  final List<String> nome;
  final List<String> plantaDano;
  final Color color;
}

List<TipoOfensor> tps = [];
const List<TipoOfensor> types = [
  TipoOfensor(
    tipo: TiposOfensor.praga,
    nome: ["Praga"],
    plantaDano: ["Todos"],
    color: Color(0xFFa8a8a8),
  ),
  TipoOfensor(
    tipo: TiposOfensor.doenca,
    nome: ["doenca"],
    plantaDano: ["Todos"],
    color: Color(0xFFa8a8a8),
  ),
  TipoOfensor(
    tipo: TiposOfensor.fungo,
    nome: ["fungo"],
    plantaDano: ["Todos"],
    color: Color(0xFFa8a8a8),
  )

];
