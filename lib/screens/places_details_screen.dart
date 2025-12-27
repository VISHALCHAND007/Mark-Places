import 'package:flutter/material.dart';
import 'package:mark_places/providers/place_provider.dart';
import 'package:provider/provider.dart';

class PlacesDetailsScreen extends StatelessWidget {
  static const routeName = "/place_details";

  const PlacesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedPlace = Provider.of<PlaceProvider>(
      context,
      listen: false,
    ).findPlaceById(placeId);

    return Scaffold(
      appBar: AppBar(title: Text(selectedPlace.title)),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 350,
            child: Hero(
              tag: selectedPlace.id,
              child: Image.file(selectedPlace.image, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  "Latitude:: ${selectedPlace.location.latitude}",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  "Longitude:: ${selectedPlace.location.longitude}",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
