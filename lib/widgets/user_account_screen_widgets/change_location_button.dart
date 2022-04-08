import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart' as geocoding;

class ChangeLocationButton extends StatelessWidget {
  const ChangeLocationButton({Key? key, required this.context})
      : super(key: key);
  final BuildContext context;

  void changeLocation() async {
    String locationName = "";
    String homeNum = '';
    String apartmentNum = '';
    await location.Location.instance.getLocation().then((value) async {
      final placeMark = await geocoding.placemarkFromCoordinates(
          value.latitude!, value.longitude!);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              clipBehavior: Clip.antiAlias,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber.shade100,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text('Home Number'),
                          hintText: 'Enter your Home Number'),
                      onChanged: (value) {
                        homeNum = value;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text('Apartment Number'),
                          hintText: 'Enter your Apartment Number'),
                      onChanged: (value) {
                        apartmentNum = value;
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Save'),
                      onPressed: () async {
                        final userId = FirebaseAuth.instance.currentUser!.uid;
                        locationName =
                            '${placeMark.first.country!}, ${placeMark.first.administrativeArea!}, ${placeMark.first.locality!}, ${placeMark.first.street!}, ${placeMark.first.postalCode!}, Home Number: $homeNum, Apartment Number: $apartmentNum';

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .update({'location': locationName});
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          changeLocation();
        },
        child: const Text(
          'Change Location',
          style: TextStyle(
              color: Color.fromARGB(255, 153, 66, 0),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ));
  }
}
