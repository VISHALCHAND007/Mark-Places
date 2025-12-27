import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];
  
  Place findPlaceById(String id) => _places.firstWhere((place) => place.id == id);

  void addPlace(String title, File clickedImg, Location fetchedLocation) {
    final newPlace = Place(
      id: DateTime.now().millisecond.toString(),
      title: title,
      image: clickedImg,
      location: Location(
        latitude: fetchedLocation.latitude,
        longitude: fetchedLocation.longitude,
      ),
    );
    _places.add(newPlace);
    notifyListeners();
    DbHelper.insert("places", {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'longitude': newPlace.location.longitude,
      'latitude': newPlace.location.latitude
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
            location: Location(latitude: item['latitude'], longitude: item['longitude']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
