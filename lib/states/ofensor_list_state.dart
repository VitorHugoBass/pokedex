part of 'states.dart';

class OfensorListState with ChangeNotifier {
  static const int _itemsPerPage = 20;

  OfensorListState(this._getOfensorsUseCase);

  final GetOfensorsUseCase _getOfensorsUseCase;

  int page = 1;
  bool loading = true;
  bool canLoadMore = true;
  bool isError = false;
  List<Ofensor> ofensor = [];

  void getOfensors({bool reset = false}) async {
    if (reset) {
      page = 1;
      canLoadMore = true;
      ofensor = [];
    }

    isError = false;
    loading = true;
    notifyListeners();

    try {
      final newOfensors = await _getOfensorsUseCase(
        GetOfensorsParams(page: page, limit: _itemsPerPage),
      );

      ofensor = [...ofensor, ...newOfensors];
      canLoadMore = newOfensors.length >= _itemsPerPage;

      if (canLoadMore) {
        page++;
      }
    } catch (e) {
      isError = true;
      canLoadMore = false;
    }

    loading = false;

    notifyListeners();
  }
}
