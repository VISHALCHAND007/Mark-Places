import 'package:flutter/material.dart';
import 'package:mark_places/screens/places_details_screen.dart';
import 'package:provider/provider.dart';
import './providers/place_provider.dart';
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PlaceProvider(),
      child: MaterialApp(
        title: '🏷 Favourite Places',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlacesDetailsScreen.routeName: (ctx) => PlacesDetailsScreen()
        },
      ),
    );
  }
}
