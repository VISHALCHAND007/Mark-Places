import 'package:flutter/material.dart';
import 'package:mark_places/screens/places_details_screen.dart';
import '../providers/place_provider.dart';
import 'package:provider/provider.dart';
import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏷 Favourite Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(
          context,
          listen: false,
        ).fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlaceProvider>(
                child: Center(
                  child: const Text(
                    "Got no places yet, start adding some!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                builder: (ctx, placesData, ch) {
                  final places = placesData.places;
                  return places.isEmpty
                      ? ch!
                      : ListView.builder(
                          itemBuilder: (ctx, ind) {
                            final place = places[ind];
                            return Column(
                              children: [
                                ListTile(
                                  leading: Hero(
                                    tag: place.id,
                                    child: CircleAvatar(
                                      backgroundImage: FileImage(place.image),
                                      radius: 30,
                                    ),
                                  ),
                                  title: Text(
                                    place.title,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    "${place.location.latitude} ${place.location.longitude}",
                                  ),
                                  trailing: Icon(
                                    Icons.place_outlined,
                                    color: Colors.blueGrey,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      PlacesDetailsScreen.routeName,
                                      arguments: place.id,
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          },
                          itemCount: places.length,
                        );
                },
              ),
      ),
    );
  }
}
