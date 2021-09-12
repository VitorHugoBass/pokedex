import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:catalogo/configs/images.dart';
import 'package:catalogo/domain/entities/ofensor.dart';
import 'package:catalogo/providers/providers.dart';
import 'package:catalogo/ui/screens/catalogo/widgets/ofensor_card.dart';
import 'package:catalogo/ui/widgets/main_app_bar.dart';
import 'package:catalogo/ui/widgets/ofensor_refresh_control.dart';
import 'package:catalogo/routes.dart';

class OfensorGrid extends StatefulWidget {
  @override
  _ofensorGridState createState() => _ofensorGridState();
}

class _ofensorGridState extends State<OfensorGrid> {
  static const double _endReachedThreshold = 200;

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  ScrollController get innerController => _scrollKey.currentState?.innerController;

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      context.read(ofensorsStateProvider).getOfensors(reset: true);
      innerController?.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    innerController?.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (innerController != null && !innerController.hasClients) return;

    final thresholdReached = innerController.position.extentAfter < _endReachedThreshold;
    final isLoading = context.read(ofensorsStateProvider).loading;
    final canLoadMore = context.read(ofensorsStateProvider).canLoadMore;

    if (thresholdReached && !isLoading && canLoadMore) {
      // Load more!
      context.read(ofensorsStateProvider).getOfensors();
    }
  }

  Future _onRefresh() async {
    context.read(ofensorsStateProvider).getOfensors(reset: true);
  }

  void _onOfensorPress(int index, Ofensor ofensor) {
    context.read(currentOfensorStateProvider).setOfensor(index, ofensor);

    AppNavigator.push(Routes.OfensorInfo, ofensor);
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return [
      MainSliverAppBar(),
    ];
  }

  Widget _buildGrid({List<Ofensor> ofensor = const []}) {
    return SliverPadding(
      padding: EdgeInsets.all(28),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => OfensorCard(
            ofensor[index],
            index: index,
            onPress: () => _onOfensorPress(index, ofensor[index]),
          ),
          childCount: ofensor.length,
        ),
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(bottom: 28),
        alignment: Alignment.center,
        child: Image(image: AppImages.embrapaLogo),
      ),
    );
  }

  Widget _buildError() {
    return SliverFillRemaining(
      child: Container(
        padding: EdgeInsets.only(bottom: 28),
        alignment: Alignment.center,
        child: Icon(
          Icons.warning_amber_rounded,
          size: 60,
          color: Colors.black26,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      key: _scrollKey,
      headerSliverBuilder: _buildHeader,
      body: Consumer(builder: (_, watch, __) {
        final OfensorState = watch(ofensorsStateProvider);

        return CustomScrollView(
          slivers: [
            OfensorRefreshControl(onRefresh: _onRefresh),
            if (OfensorState.isError)
              _buildError()
            else ...[
              _buildGrid(ofensor: OfensorState.ofensor),
              if (OfensorState.canLoadMore) _buildLoadMoreIndicator(),
            ]
          ],
        );
      }),
    );
  }
}
