import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:catalogo/configs/durations.dart';
import 'package:catalogo/core/extensions/animation.dart';
import 'package:catalogo/ui/modals/generation_modal.dart';
import 'package:catalogo/ui/modals/search_modal.dart';
import 'package:catalogo/ui/screens/catalogo/widgets/ofensor_grid.dart';
import 'package:catalogo/ui/widgets/fab.dart';
import 'package:catalogo/ui/widgets/pokeball_background.dart';

part 'package:catalogo/ui/screens/catalogo/widgets/fab_menu.dart';
part 'package:catalogo/ui/screens/catalogo/widgets/fab_overlay_background.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen();

  @override
  State<StatefulWidget> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> with SingleTickerProviderStateMixin {
  Animation<double> _fabAnimation;
  AnimationController _fabController;
  bool _isFabMenuVisible = false;

  @override
  void initState() {
    _fabController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    _fabAnimation = _fabController.curvedTweenAnimation(
      begin: 0.0,
      end: 1.0,
    );

    super.initState();
  }

  @override
  void dispose() {
    _fabController?.dispose();

    super.dispose();
  }

  void _toggleFabMenu() {
    _isFabMenuVisible = !_isFabMenuVisible;

    if (_isFabMenuVisible) {
      _fabController.forward();
    } else {
      _fabController.reverse();
    }
  }

  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchBottomModal(),
    );
  }

  void _showGenerationModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GenerationModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PokeballBackground(
      child: Stack(
        children: [
          OfensorGrid(),
          _FabOverlayBackground(
            animation: _fabAnimation,
            onPressOut: _toggleFabMenu,
          ),
        ],
      ),
      floatingActionButton: _FabMenu(
        animation: _fabAnimation,
        toggle: _toggleFabMenu,
        onAllGenPress: _showGenerationModal,
        onSearchPress: _showSearchModal,
      ),
    );
  }
}
