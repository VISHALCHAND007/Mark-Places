import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _locationImgUrl;

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();
    print('${locationData.longitude}, ${locationData.latitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: _locationImgUrl == null
              ? Text("No location chosen!")
              : Image.network(
                  _locationImgUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: .center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: Text("Current location"),
              icon: Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {},
              label: Text("Select on map"),
              icon: Icon(Icons.map_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
