import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mark_places/models/place.dart' as loc;

class CurrentLocation extends StatelessWidget {
  final Function(loc.Location) onLocationFetched;

  const CurrentLocation({required this.onLocationFetched, super.key});

  Future<loc.Location> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      final location = loc.Location(
        latitude: locData.latitude ?? 0.0,
        longitude: locData.longitude ?? 0.0,
      );
      onLocationFetched(location);
      return location;
    } catch (error) {
      throw Exception("Failed to get the location.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCurrentLocation(),
      builder: (ctx, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              )
            : Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .center,
                children: [
                  Text(
                    "${snapshot.data?.latitude}, ${snapshot.data?.longitude}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  // to show the lat and long
                  TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.location_on),
                    label: Text("Current location"),
                  ),
                ],
              );
      },
    );
  }
}
