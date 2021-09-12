import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:catalogo/configs/colors.dart';
import 'package:catalogo/core/extensions/context.dart';
import 'package:catalogo/domain/entities/ofensor.dart';
import 'package:catalogo/providers/providers.dart';
import 'package:catalogo/ui/screens/Ofensor_info/widgets/tab_about.dart';
import 'package:catalogo/ui/screens/Ofensor_info/widgets/tab_base_stats.dart';
import 'package:catalogo/ui/screens/Ofensor_info/widgets/tab_evolution.dart';

class TabData {
  const TabData({
    this.label,
    this.builder,
  });

  final Widget Function(Ofensor ofensor, Animation animation) builder;
  final String label;
}

class OfensorTabInfo extends StatelessWidget {
  final Animation _animation;

  final List<TabData> _tabs = [
    TabData(
      label: 'About',
      builder: (Ofensor, animation) => OfensorAbout(Ofensor, animation),
    ),
    TabData(
      label: 'Base Stats',
      builder: (Ofensor, animation) => OfensorBaseStats(Ofensor, animation),
    ),
    TabData(
      label: 'Evolution',
      builder: (Ofensor, animation) => OfensorEvolution(Ofensor, animation),
    ),
    TabData(
      label: 'Moves',
      builder: (Ofensor, animation) => Container(
        alignment: Alignment.topCenter,
        child: Text('Under development'),
      ),
    ),
  ];

  OfensorTabInfo(this._animation);

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
      labelColor: AppColors.black,
      unselectedLabelColor: AppColors.grey,
      labelPadding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: context.responsive(16),
      ),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorColor: AppColors.indigo,
      tabs: _tabs.map((tab) => Text(tab.label)).toList(),
    );
  }

  Widget _buildTabContent() {
    return Expanded(
      child: Consumer(builder: (_, watch, __) {
        final currentOfensor = watch(currentOfensorStateProvider).ofensor;

        return TabBarView(
          children: _tabs.map((tab) => tab.builder(currentOfensor, _animation)).toList(),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenSize.width;
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) =>
                  SizedBox(height: context.responsive((1 - _animation.value) * 16 + 6)),
            ),
            _buildTabBar(context),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }
}
