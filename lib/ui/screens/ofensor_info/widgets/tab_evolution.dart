import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:catalogo/configs/colors.dart';
import 'package:catalogo/configs/images.dart';
import 'package:catalogo/core/extensions/context.dart';
import 'package:catalogo/domain/entities/ofensor.dart';
import 'package:catalogo/ui/widgets/spacer.dart';

class OfensorBall extends StatelessWidget {
  const OfensorBall(this.ofensor);

  final Ofensor ofensor;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenSize.height;
    final pokeballSize = screenHeight * 0.1;
    final OfensorSize = pokeballSize * 0.85;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              image: AppImages.pokeball,
              width: pokeballSize,
              height: pokeballSize,
              color: AppColors.lightGrey,
            ),
            CachedNetworkImage(
              imageUrl: ofensor.image,
              imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage,
              useOldImageOnUrlChange: true,
              imageBuilder: (_, image) => Image(
                image: image,
                width: OfensorSize,
                height: OfensorSize,
              ),
              errorWidget: (_, __, error) => Stack(
                alignment: Alignment.center,
                children: [
                  Image(
                    image: AppImages.bulbasaur,
                    width: OfensorSize,
                    height: OfensorSize,
                    color: Colors.black12,
                  ),
                  Icon(
                    Icons.warning_amber_rounded,
                    size: OfensorSize * 0.3,
                    color: Colors.black26,
                  ),
                ],
              ),
            )
          ],
        ),
        VSpacer(context.responsive(3)),
        Text(ofensor.name),
      ],
    );
  }
}

class OfensorEvolution extends StatefulWidget {
  final Animation animation;
  final Ofensor ofensor;

  const OfensorEvolution(this.ofensor, this.animation);

  @override
  _OfensorEvolutionState createState() => _OfensorEvolutionState();
}

class _OfensorEvolutionState extends State<OfensorEvolution> {
  Widget _buildRow({Ofensor current, Ofensor next, String reason}) {
    return Row(
      children: <Widget>[
        Expanded(child: OfensorBall(current)),
        Expanded(
          child: Column(
            children: <Widget>[
              Icon(Icons.arrow_forward, color: AppColors.lightGrey),
              VSpacer(context.responsive(7)),
              Text(
                reason,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(child: OfensorBall(next)),
      ],
    );
  }

  Widget _buildDivider() {
    return Column(
      children: <Widget>[
        VSpacer(context.responsive(21)),
        Divider(),
        VSpacer(context.responsive(21)),
      ],
    );
  }

  List<Widget> buildEvolutionList(List<Ofensor> Ofensors) {
    if (Ofensors.length < 2) {
      return [
        Center(child: Text('No evolution')),
      ];
    }

    return Iterable<int>.generate(Ofensors.length - 1) // skip the last one
        .map(
          (index) => _buildRow(
            current: Ofensors[index],
            next: Ofensors[index + 1],
            reason: Ofensors[index + 1].evolutionReason,
          ),
        )
        .expand((widget) => [widget, _buildDivider()])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Evolution Chain',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 0.8),
          ),
          VSpacer(context.responsive(28)),
          ...buildEvolutionList(widget.ofensor.evolutions),
        ],
      ),
      builder: (context, child) {
        final scrollable = widget.animation.value.floor() == 1;

        return SingleChildScrollView(
          physics: scrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            vertical: context.responsive(31),
            horizontal: 28,
          ),
          child: child,
        );
      },
    );
  }
}
