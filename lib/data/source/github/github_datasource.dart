import 'dart:convert';

import 'package:catalogo/core/network.dart';
import 'package:catalogo/data/source/github/models/ofensor.dart';

class GithubDataSource {
  static const String url =
      'https://gist.githubusercontent.com/scitbiz/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/Ofensors.json';

  GithubDataSource(this.networkManager);

  final NetworkManager networkManager;

  Future<List<GithubOfensorModel>> getOfensors() async {
    final response = await networkManager.request(RequestMethod.get, url);

    final data = (json.decode(response.data) as List)
        .map((item) => GithubOfensorModel.fromJson(item))
        .toList();

    return data;
  }
}
