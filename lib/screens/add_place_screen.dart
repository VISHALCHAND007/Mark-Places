import 'package:flutter/material.dart';
import '../widgets/take_picture.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";

  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add a new place")),
      body: Column(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
              ),
              SizedBox(height: 15,),
              TakePicture()
            ]),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            onPressed: () {},
            label: Text("Add Place"),
            style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          ),
        ],
      ),
    );
  }
}
