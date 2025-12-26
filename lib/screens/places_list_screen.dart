import 'package:flutter/material.dart';
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
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(place.image),
                              ),
                              title: Text(place.title),
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
