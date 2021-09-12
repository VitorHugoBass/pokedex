import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:catalogo/configs/colors.dart';
import 'package:catalogo/domain/entities/ofensor.dart';
import 'package:catalogo/ui/widgets/Ofensor_type.dart';
import 'package:catalogo/ui/widgets/progress.dart';
import 'package:catalogo/ui/widgets/spacer.dart';
import 'package:catalogo/utils/string.dart';
import 'package:catalogo/core/extensions/context.dart';

class Stat extends StatelessWidget {
  const Stat({
    @required this.animation,
    @required this.label,
    @required this.value,
    this.progress,
  });

  final Animation animation;
  final String label;
  final double progress;
  final num value;

  @override
  Widget build(BuildContext context) {
    final currentProgress = progress ?? value / 100;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(color: AppColors.black.withOpacity(0.6)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text('$value'),
        ),
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, widget) => ProgressBar(
              progress: animation.value * currentProgress,
              color: currentProgress < 0.5 ? AppColors.red : AppColors.teal,
              enableAnimation: animation.value == 1,
            ),
          ),
        ),
      ],
    );
  }
}

class OfensorBaseStats extends StatefulWidget {
  final Ofensor ofensor;
  final Animation<double> scrollAnimation;

  const OfensorBaseStats(this.ofensor, this.scrollAnimation);

  @override
  _OfensorBaseStatsState createState() => _OfensorBaseStatsState();
}

class _OfensorBaseStatsState extends State<OfensorBaseStats> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  Ofensor get ofensor => widget.ofensor;
  Animation<double> get scrollAnimation => widget.scrollAnimation;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _controller,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    _controller.forward();
  }

  List<Widget> generateStatWidget() {
    return [
      Stat(animation: _animation, label: 'Hp', value: ofensor.tempoDuracaoFase.ovoTime),
      VSpacer(context.responsive(14)),
      Stat(animation: _animation, label: 'Atttack', value: ofensor.tempoDuracaoFase.lagartaTime),
      VSpacer(context.responsive(14)),
      Stat(animation: _animation, label: 'Defense', value: ofensor.tempoDuracaoFase.prePupaTime),
      VSpacer(context.responsive(14)),
      Stat(animation: _animation, label: 'Sp. Atk', value: ofensor.tempoDuracaoFase.pupaTime),
      VSpacer(context.responsive(14)),
      Stat(animation: _animation, label: 'Sp. Def', value: ofensor.tempoDuracaoFase.adultoTime),
      VSpacer(context.responsive(14)),
      Stat(animation: _animation, label: 'Speed', value: ofensor.tempoDuracaoFase.preOviposicaoTime),
      VSpacer(context.responsive(14)),
      Stat(
        animation: _animation,
        label: 'Total',
        value: 100,
        progress: 100 / 600,
      ),
    ];
  }

  List<Widget> _buildEffectivenesses() {
    // final effectiveness = ofensor.typeEffectiveness;
    // final list = effectiveness.keys
    //     .map(
    //       (type) => OfensorType(
    //         type,
    //         large: true,
    //         colored: true,
    //         extra: 'x' + removeTrailingZero(effectiveness[type]),
    //       ),
    //     )
    //     .toList();
    //Aqui podemos usar para chamar a classe que pode ser usada para defensivos agricolas
    return null ;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ...generateStatWidget(),
          VSpacer(context.responsive(27)),
          Text(
            'Type defenses',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 0.8,
            ),
          ),
          VSpacer(context.responsive(15)),
          Text(
            'The effectiveness of each type on ${ofensor.name}.',
            style: TextStyle(color: AppColors.black.withOpacity(0.6)),
          ),
          VSpacer(context.responsive(15)),
          Wrap(
            spacing: context.responsive(8),
            runSpacing: context.responsive(8),
            children: _buildEffectivenesses(),
          ),
        ],
      ),
      builder: (context, child) {
        final scrollable = scrollAnimation.value.floor() == 1;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: context.responsive(24),
            horizontal: 24,
          ),
          physics: scrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
          child: child,
        );
      },
    );
  }
}
