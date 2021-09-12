import 'package:flutter/foundation.dart';

class Generation {
  const Generation({
    @required this.title,
    @required this.ofensors,
  });

  final List<String> ofensors;
  final String title;
}
