import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mark_places/providers/place_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/take_picture.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";

  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final titleController = TextEditingController();
  late File _savedImage;

  void _setImage(File savedImage) {
    _savedImage = savedImage;
  }

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context, listen: false);
    final navigator = Navigator.of(context);

    void savePlace() async {
      if (titleController.text.isEmpty || await _savedImage.exists() == false) {
        return;
      }
      placeProvider.addPlace(titleController.text, _savedImage);
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
                TextField(
                  decoration: InputDecoration(labelText: "Title"),
                  controller: titleController,
                ),
                SizedBox(height: 15),
                TakePicture(_setImage),
              ],
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            onPressed: savePlace,
            label: Text("Add Place"),
            style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          ),
        ],
      ),
    );
  }
}
