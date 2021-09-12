

import 'package:catalogo/domain/entities/ofensor.dart';
import 'package:catalogo/domain/usecases/ofensor_usecases.dart';
import 'package:flutter/cupertino.dart';

class CurrentOfensorState with ChangeNotifier {
  CurrentOfensorState(this._getOfensorUseCase);

  final GetOfensorUseCase _getOfensorUseCase;

  int index;
  Ofensor ofensor;

  void setOfensor(int newIndex, Ofensor newOfensor) async {
    index = newIndex;
    ofensor = await _getOfensorUseCase(GetOfensorParam(newOfensor.id));
    notifyListeners();
  }
}
