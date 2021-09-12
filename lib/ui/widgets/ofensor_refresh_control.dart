import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:catalogo/configs/images.dart';

class OfensorRefreshControl extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const OfensorRefreshControl({
    Key key,
    @required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      builder: (_, __, ___, ____, _____) => Image(
        image: AppImages.embrapaLogo,
      ),
    );
  }
}
