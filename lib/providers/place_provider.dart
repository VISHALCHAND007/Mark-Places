import 'package:flutter/foundation.dart';

import '../models/place.dart';

class PlaceProvider with ChangeNotifier {
  final List<Place> _places = [];

  List<Place> get places => [..._places];
}