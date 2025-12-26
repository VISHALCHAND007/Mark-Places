import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  void addPlace(String title, File clickedImg) {
    final newPlace = Place(
      id: DateTime.now().millisecond.toString(),
      title: title,
      image: clickedImg,
      location: Location(latitude: 0.0, longitude: 0.0),
    );
    _places.add(newPlace);
    notifyListeners();
    DbHelper.insert("places", {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final placesList = await DbHelper.fetchPlaces();
    _places = placesList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: Location(latitude: 0, longitude: 0),
          ),
        )
        .toList();
    notifyListeners();
  }
}
