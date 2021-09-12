import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalogo/domain/entities/ofensor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:catalogo/configs/durations.dart';
import 'package:catalogo/configs/images.dart';
import 'package:catalogo/core/extensions/context.dart';
import 'package:catalogo/providers/providers.dart';
import 'package:catalogo/ui/widgets/animated_fade.dart';
import 'package:catalogo/ui/widgets/animated_slide.dart';
import 'package:catalogo/ui/widgets/main_app_bar.dart';
import 'package:catalogo/ui/widgets/Ofensor_type.dart';
import 'package:catalogo/ui/widgets/spacer.dart';

class OfensorOverallInfo extends StatefulWidget {
  final Ofensor ofensor;
  final AnimationController controller;
  final AnimationController rotateController;

  const OfensorOverallInfo(this.ofensor, this.controller, this.rotateController);

  @override
  _OfensorOverallInfoState createState() => _OfensorOverallInfoState();
}

class _OfensorOverallInfoState extends State<OfensorOverallInfo> with TickerProviderStateMixin {
  static const double _OfensorSliderViewportFraction = 0.6;
  static const int _endReachedThreshold = 4;

  final GlobalKey _currentTextKey = GlobalKey();
  final GlobalKey _targetTextKey = GlobalKey();

  double textDiffLeft = 0.0;
  double textDiffTop = 0.0;
  PageController _pageController;
  AnimationController _slideController;

  Ofensor get Ofensor => widget.ofensor;

  AnimationController get controller => widget.controller;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
    _slideController.forward();

    _calculateOfensorNamePosition();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _pageController ??= PageController(
      viewportFraction: _OfensorSliderViewportFraction,
      initialPage: context.read(currentOfensorStateProvider).index,
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _slideController?.dispose();
    _pageController?.dispose();

    super.dispose();
  }

  void _calculateOfensorNamePosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox targetTextBox = _targetTextKey.currentContext.findRenderObject();
      final targetTextPosition = targetTextBox.localToGlobal(Offset.zero);

      final currentTextBox = _currentTextKey.currentContext.findRenderObject() as RenderBox;
      final currentTextPosition = currentTextBox.localToGlobal(Offset.zero);

      final newDiffLeft = targetTextPosition.dx - currentTextPosition.dx;
      final newDiffTop = targetTextPosition.dy - currentTextPosition.dy;

      if (newDiffLeft != textDiffLeft || newDiffTop != textDiffTop) {
        setState(() {
          textDiffLeft = newDiffLeft;
          textDiffTop = newDiffTop;
        });
      }
    });
  }

  AppBar _buildAppBar() {
    return MainAppBar(
      // A placeholder for easily calculate the translate of the Ofensor name
      title: Consumer(builder: (_, watch, __) {
        _calculateOfensorNamePosition();

        return Text(
          watch(currentOfensorStateProvider).ofensor.name,
          key: _targetTextKey,
          style: TextStyle(
            color: Colors.transparent,
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        );
      }),
      rightIcon: Icons.favorite_border,
    );
  }

  Widget _buildOfensorName() {
    final fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(controller);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final value = controller.value ?? 0.0;

              return Transform.translate(
                offset: Offset(textDiffLeft * value, textDiffTop * value),
                child: Consumer(builder: (_, watch, __) {
                  final OfensorName = watch(currentOfensorStateProvider).ofensor.name;

                  return Hero(
                    tag: OfensorName,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        OfensorName,
                        key: _currentTextKey,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 36 - (36 - 22) * value,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
          AnimatedSlide(
            animation: _slideController,
            child: AnimatedFade(
              animation: fadeAnimation,
              child: Consumer(builder: (_, watch, __) {
                final tag = watch(currentOfensorStateProvider).ofensor;

                return Hero(
                  tag: tag.id,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      tag.id,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfensorTypes() {
    final fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(controller);

    return AnimatedFade(
      animation: fadeAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26),
        child: Consumer(builder: (_, watch, __) {
          final Ofensor = watch(currentOfensorStateProvider).ofensor;

          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Wrap(
                  spacing: context.responsive(8),
                  runSpacing: context.responsive(8),
                  children: Ofensor.types
                      .map(
                        (type) => Hero(
                          tag: type,
                          child: OfensorType(type, large: true),
                        ),
                      )
                      .toList(),
                ),
              ),
              AnimatedSlide(
                animation: _slideController,
                child: Text(
                  Ofensor.genera,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildOfensorSlider() {
    final screenSize = context.screenSize;
    final fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    return AnimatedFade(
      animation: fadeAnimation,
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height * 0.24,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: RotationTransition(
                turns: widget.rotateController,
                child: Image(
                  image: AppImages.pokeball,
                  width: screenSize.height * 0.24,
                  height: screenSize.height * 0.24,
                  color: Colors.white.withOpacity(0.14),
                ),
              ),
            ),
            Consumer(builder: (context, watch, __) {
              final OfensorsState = watch(OfensorsStateProvider);
              final currentOfensorState = watch(currentOfensorStateProvider);

              final Ofensors = OfensorsState.ofensor;

              return PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: Ofensors.length,
                onPageChanged: (index) {
                  currentOfensorState.setOfensor(index, Ofensors[index]);

                  final thresholdReached = index >= Ofensors.length - _endReachedThreshold;

                  if (OfensorsState.canLoadMore && thresholdReached) {
                    OfensorsState.getOfensors();
                  }
                },
                itemBuilder: (context, index) {
                  final selected = currentOfensorState.index == index;
                  final imageSize = screenSize.height * 0.3;

                  return Hero(
                    tag: selected ? Ofensors[index].image : index,
                    child: AnimatedPadding(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeOutQuint,
                      padding: EdgeInsets.only(
                        top: selected ? 0 : screenSize.height * 0.04,
                        bottom: selected ? 0 : screenSize.height * 0.04,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: Ofensors[index].image,
                        imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage,
                        useOldImageOnUrlChange: true,
                        imageBuilder: (context, image) => Image(
                          image: image,
                          width: imageSize,
                          height: imageSize,
                          alignment: Alignment.bottomCenter,
                          color: selected ? null : Colors.black26,
                          fit: BoxFit.contain,
                        ),
                        errorWidget: (_, __, error) => Stack(
                          alignment: Alignment.center,
                          children: [
                            Image(
                              image: AppImages.bulbasaur,
                              width: imageSize,
                              height: imageSize,
                              color: Colors.black12,
                            ),
                            Icon(
                              Icons.warning_amber_rounded,
                              size: imageSize * 0.3,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildAppBar(),
        VSpacer(context.responsive(9)),
        _buildOfensorName(),
        VSpacer(context.responsive(9)),
        _buildOfensorTypes(),
        VSpacer(context.responsive(25)),
        _buildOfensorSlider(),
      ],
    );
  }
}
