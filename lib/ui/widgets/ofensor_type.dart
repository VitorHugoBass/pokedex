import 'package:flutter/material.dart';
import 'package:catalogo/domain/entities/tipos_ofensor.dart';
import 'package:catalogo/core/extensions/context.dart';
import 'package:catalogo/ui/widgets/spacer.dart';

class Ofensortipo extends StatelessWidget {
  const Ofensortipo(
    this.tipo, {
    Key key,
    this.large = false,
    this.colored = false,
    this.extra = '',
  }) : super(key: key);

  final TiposOfensor tipo;
  final String extra;
  final bool large;
  final bool colored;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: large ? 19 : 12,
          vertical: context.responsive(large ? 6 : 4),
        ),
        decoration: ShapeDecoration(
          shape: StadiumBorder(),
          color: (Colors.white).withOpacity(0.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Tipo",
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: large ? 12 : 8,
                height: 0.8,
                fontWeight: large ? FontWeight.bold : FontWeight.normal,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            HSpacer(5),
            Text(
              extra,
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: large ? 12 : 8,
                height: 0.8,
                fontWeight: large ? FontWeight.bold : FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
