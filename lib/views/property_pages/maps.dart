import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';

// ignore: must_be_immutable
class MapPage extends StatefulWidget {
  late Position currentPosition;
  late String task;
  MapPage({
    super.key,
    required this.currentPosition,
    required this.task,
  });
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String currentAddress = "Tap on location of your entity on Map.";
  late GoogleMapController mapController;
  LatLng selectedPoint = const LatLng(37.7749, -122.4194); // Default point
  late Placemark place;
  String placename = "Select location on Map";

  Future<void> _determineAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        selectedPoint.latitude,
        selectedPoint.longitude,
      );
      place = placemarks[0];
      currentAddress =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      placename = "${place.name}";
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;
    // double sh = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.task,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      )),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.currentPosition.latitude,
                        widget.currentPosition.longitude),
                    zoom: 15.0,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('selectedPoint'),
                      position: selectedPoint,
                      draggable: true,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure),
                      onDragEnd: (LatLng newPosition) {
                        setState(() {
                          selectedPoint = newPosition;
                        });
                      },
                    ),
                  },
                  onTap: (LatLng tapPoint) async {
                    setState(() {
                      selectedPoint = tapPoint;
                    });
                    await _determineAddress();
                    setState(() {
                      placename = placename;
                      currentAddress = currentAddress;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: SizedBox(
                      height: 45,
                      width: sw * 0.7,
                      child: RoundedButton(
                          title: "Use my Current Location",
                          leftWidth: 9,
                          iconsDataLeft: Icons.location_searching_rounded,
                          iconColor: Colors.white,
                          fontsize: 14,
                          radius: 15,
                          buttonColor: const Color.fromRGBO(247, 147, 29, 1),
                          onTap: () async {
                            setState(() {
                              selectedPoint = LatLng(
                                  widget.currentPosition.latitude,
                                  widget.currentPosition.longitude);
                            });
                            await _determineAddress();
                            if (mounted) {
                              setState(() {
                                placename = placename;
                                currentAddress = currentAddress;
                              });
                            }
                          }),
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(sw * 0.07),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(sw * 0.05, 0, sw * 0.05, 0),
                    child: Row(
                      children: [
                        if (placename != "")
                          const Icon(
                            Icons.location_on,
                            size: 25,
                            color: Color.fromRGBO(24, 72, 241, 1),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          placename,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(sw * 0.05, 0, sw * 0.05, 0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 35,
                          height: 0,
                        ),
                        SizedBox(
                            width: sw * 0.6,
                            child: Text(
                              currentAddress,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 99, 99, 99)),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  RoundedButton(
                    title: "Continue",
                    radius: 15,
                    buttonColor: const Color.fromRGBO(15, 98, 223, 1),
                    onTap: () {
                      Get.back(result: selectedPoint);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
