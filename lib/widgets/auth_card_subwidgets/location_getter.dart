import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart' as geocoding;

typedef StringCallback = void Function(String location);

class LocationGetter extends StatefulWidget {
  const LocationGetter({Key? key, required this.locationCallback})
      : super(key: key);
  final StringCallback locationCallback;

  @override
  State<LocationGetter> createState() => _LocationGetterState();
}

class _LocationGetterState extends State<LocationGetter> {
  String locationName = "";
  String homeNum = '';
  String apartmentNum = '';

  void getLocation() async {
    await location.Location.instance.getLocation().then((value) async {
      final placeMark = await geocoding.placemarkFromCoordinates(
          value.latitude!, value.longitude!);
      showBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 200,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text('Home Number'),
                        hintText: 'Enter your Home Number'),
                    onChanged: (value) {
                      setState(() {
                        homeNum = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text('Apartment Number'),
                        hintText: 'Enter your Apartment Number'),
                    onChanged: (value) {
                      setState(() {
                        apartmentNum = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      setState(() {
                        locationName =
                            '${placeMark.first.country!}, ${placeMark.first.administrativeArea!}, ${placeMark.first.locality!}, ${placeMark.first.street!}, ${placeMark.first.postalCode!}, Home Number: $homeNum, Apartment Number: $apartmentNum';
                      });
                      Navigator.of(context).pop();
                      widget.locationCallback(locationName);
                    },
                  ),
                ],
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(locationName.isEmpty ? 'No Location' : locationName),
        ),
        TextButton.icon(
            onPressed: () {
              getLocation();
            },
            icon: const Icon(Icons.location_on),
            label: const Text('Get Location'))
      ],
    );
  }
}
