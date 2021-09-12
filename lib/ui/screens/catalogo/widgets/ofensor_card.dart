import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalogo/configs/types.dart';
import 'package:catalogo/domain/entities/tipos_ofensor.dart';
import 'package:flutter/material.dart';
import 'package:catalogo/configs/images.dart';
import 'package:catalogo/domain/entities/ofensor.dart';
import 'package:catalogo/ui/widgets/ofensor_type.dart';
import 'package:catalogo/core/extensions/context.dart';
import 'package:catalogo/ui/widgets/spacer.dart';

class OfensorCard extends StatelessWidget {
  static const double _pokeballFraction = 0.75;
  static const double _ofensorFraction = 0.76;

  const OfensorCard(
    this.ofensor, {
    this.onPress,
    @required this.index,
  });

  final int index;
  final Function onPress;
  final Ofensor ofensor;

  Widget _buildPokeballDecoration({@required double height}) {
    final pokeballSize = height * _pokeballFraction;

    return Positioned(
      bottom: -height * 0.13,
      right: -height * 0.03,
      child: Image(
        image: AppImages.pokeball,
        width: pokeballSize,
        height: pokeballSize,
        color: Colors.white.withOpacity(0.14),
      ),
    );
  }

  Widget _buildOfensor({@required double height}) {
    final ofensorSize = height * _ofensorFraction;

    return Positioned(
      bottom: -2,
      right: 2,
      child: Hero(
        tag: ofensor.image,
        child: CachedNetworkImage(
          imageUrl: ofensor.image,
          width: ofensorSize,
          height: ofensorSize,
          imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage,
          useOldImageOnUrlChange: true,
          fit: BoxFit.contain,
          alignment: Alignment.bottomRight,
          placeholder: (context, url) => Image(
            image: AppImages.bulbasaur,
            width: ofensorSize,
            height: ofensorSize,
            color: Colors.black12,
          ),
          errorWidget: (_, __, error) => Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: AppImages.bulbasaur,
                width: ofensorSize,
                height: ofensorSize,
                color: Colors.black12,
              ),
              Icon(
                Icons.warning_amber_rounded,
                size: ofensorSize * 0.4,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfensorNumber() {
    return Positioned(
      top: 10,
      right: 14,
      child: Text(
        ofensor.id.toString(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;

        return Container(
          decoration: BoxDecoration(
            color: ofensor.color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: ofensor.color.withOpacity(0.12),
                blurRadius: 30,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: ofensor.color,
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildPokeballDecoration(height: itemHeight),
                    _buildOfensor(height: itemHeight),
                    _buildOfensorNumber(),
                    _CardContent(ofensor),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent(this.ofensor, {Key key}) : super(key: key);

  final Ofensor ofensor;

  List<Widget> _buildTypes(BuildContext context) {
    return ofensor.tipo
        .take(2)
        .map(
          (type) => Padding(
            padding: EdgeInsets.symmetric(vertical: context.responsive(3)),
            child: TiposOfensor(type),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: context.responsive(24),
          bottom: context.responsive(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Hero(
              tag: ofensor.id.toString() + ofensor.name,
              child: Text(
                ofensor.name,
                style: TextStyle(
                  fontSize: 14,
                  height: 0.7,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            VSpacer(context.responsive(10)),
            ..._buildTypes(context),
          ],
        ),
      ),
    );
  }
}
