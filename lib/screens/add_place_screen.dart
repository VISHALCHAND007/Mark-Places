import 'dart:io';

import 'package:mark_places/models/place.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import '../providers/place_provider.dart';
import '../widgets/current_location.dart';
import '../widgets/take_picture.dart';
// import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";

  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final titleController = TextEditingController();
  late File _savedImage;
  Location? _savedLocation;

  void _setImage(File savedImage) {
    _savedImage = savedImage;
  }

  void _setLocation(Location savedLocation) {
    _savedLocation = savedLocation;
  }

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context, listen: false);
    final navigator = Navigator.of(context);

    void savePlace() async {
      if (titleController.text.isEmpty ||
          await _savedImage.exists() == false ||
          _savedLocation == null) {
        return;
      }
      placeProvider.addPlace(
        titleController.text,
        _savedImage,
        _savedLocation!,
      );
      navigator.pop();
    }

    return Scaffold(
      appBar: AppBar(title: Text("Add a new place")),
      body: Column(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                CurrentLocation(onLocationFetched: _setLocation),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Title"),
                  controller: titleController,
                ),
                SizedBox(height: 15),
                TakePicture(_setImage),
                SizedBox(height: 15),
                // LocationInput()
              ],
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            onPressed: savePlace,
            label: Text("Add Place"),
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: const WidgetStatePropertyAll(
                Colors.blueGrey,
              ),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
