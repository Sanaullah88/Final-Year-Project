// // // import 'dart:async';
// // // import 'dart:typed_data';

// // // import 'package:flutter/material.dart';
// // // import 'package:fyp/custom_icon.dart';
// // // import 'package:fyp/ui/reusable/global_widget.dart';
// // // import 'package:fluttertoast/fluttertoast.dart';
// // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // import 'dart:ui' as ui;

// // // class GoogleMaps13Page extends StatefulWidget {
// // //   @override
// // //   _GoogleMaps13PageState createState() => _GoogleMaps13PageState();
// // // }

// // // class _GoogleMaps13PageState extends State<GoogleMaps13Page> {
// // //   // initialize global widget
// // //   final _globalWidget = GlobalWidget();

// // //   late GoogleMapController _controller;
// // //   bool _mapLoading = true;
// // //   Timer? _timerDummy;

// // //   double _currentZoom = 14;

// // //   final LatLng _initialPosition = LatLng(-6.168033, 106.900467);

// // //   Marker? _marker;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _timerDummy?.cancel();
// // //     super.dispose();
// // //   }

// // //   // this function is to create custom marker with label at the top of icon
// // //   Future<BitmapDescriptor> _createIconLabel({String label='label', IconData icon=Icons.directions_car, double iconSize=50, double fontSize=30, labelColor: Colors.pinkAccent}) async {
// // //     ui.PictureRecorder recorder = ui.PictureRecorder();
// // //     final canvas = Canvas(recorder);
// // //     CustomIcon iconLabeling = CustomIcon(iconLabel: label, iconData: icon, iconSize: iconSize, iconColor: Colors.green[800]!, labelColor: labelColor, fontSize: fontSize);

// // //     final textPainter = TextPainter(
// // //         text: TextSpan(
// // //           text: label,
// // //           style: TextStyle(fontSize: fontSize),
// // //         ),
// // //         textDirection: TextDirection.ltr);
// // //     textPainter.layout();

// // //     iconLabeling.paint(canvas, Size(textPainter.size.width + 30, textPainter.size.height + 25));
// // //     final ui.Image image = await recorder.endRecording().toImage(
// // //         textPainter.size.width.toInt() + 30,
// // //         textPainter.size.height.toInt() + 25 + iconSize.toInt());
// // //     final ByteData byteData = (await image.toByteData(format: ui.ImageByteFormat.png))!;

// // //     Uint8List data = byteData.buffer.asUint8List();

// // //     return BitmapDescriptor.fromBytes(data);
// // //   }

// // //   // add marker
// // //   void _addMarker(double lat, double lng) {
// // //     LatLng position = LatLng(lat, lng);

// // //     _createIconLabel(label: 'My Car', icon: Icons.directions_car).then((BitmapDescriptor customIcon) {
// // //       setState(() {
// // //         _marker = Marker(
// // //           markerId: MarkerId('marker1'),
// // //           anchor: Offset(0.5, 0.5),
// // //           position: position,
// // //           onTap: () {
// // //             _createIconLabel(label: 'My Car', icon: Icons.directions_car, labelColor: Colors.blue).then((BitmapDescriptor customIcon2) {
// // //               setState(() {
// // //                 _marker = _marker!.copyWith(
// // //                   iconParam: customIcon2,
// // //                 );
// // //               });
// // //             });
// // //             Fluttertoast.showToast(msg: 'Click marker', toastLength: Toast.LENGTH_SHORT);
// // //           },
// // //           icon: customIcon,
// // //         );
// // //       });
// // //     });

// // //     CameraUpdate u2 = CameraUpdate.newCameraPosition(CameraPosition(target: position, zoom: 15));

// // //     this._controller.moveCamera(u2).then((void v) {
// // //       _check(u2, this._controller);
// // //     });
// // //   }

// // //   /* start additional function for camera update
// // //   - we get this function from the internet
// // //   - if we don't use this function, the camera will not work properly (Zoom to marker sometimes not work)
// // //   */
// // //   void _check(CameraUpdate u, GoogleMapController c) async {
// // //     c.moveCamera(u);
// // //     _controller.moveCamera(u);
// // //     LatLngBounds l1 = await c.getVisibleRegion();
// // //     LatLngBounds l2 = await c.getVisibleRegion();

// // //     if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
// // //       _check(u, c);
// // //   }

// // //   // when the Google Maps Camera is change, get the current position
// // //   void _onGeoChanged(CameraPosition position) {
// // //     _currentZoom = position.zoom;
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: _globalWidget.globalAppBar(),
// // //       body: Stack(
// // //         children: [
// // //           _buildGoogleMap(),
// // //           (_mapLoading)?Container(
// // //             width: MediaQuery.of(context).size.width,
// // //             height: MediaQuery.of(context).size.height,
// // //             color: Colors.grey[100],
// // //             child: Center(
// // //               child: CircularProgressIndicator(),
// // //             ),
// // //           ):SizedBox.shrink()
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // build google maps to used inside widget
// // //   Widget _buildGoogleMap() {
// // //     return GoogleMap(
// // //       mapType: MapType.normal,
// // //       trafficEnabled: false,
// // //       compassEnabled: true,
// // //       rotateGesturesEnabled: true,
// // //       scrollGesturesEnabled: true,
// // //       tiltGesturesEnabled: true,
// // //       zoomControlsEnabled: false,
// // //       zoomGesturesEnabled: true,
// // //       myLocationButtonEnabled: false,
// // //       myLocationEnabled: true,
// // //       mapToolbarEnabled: true,
// // //       markers: Set.of((_marker != null) ? [_marker!] : []),
// // //       initialCameraPosition: CameraPosition(
// // //         target: _initialPosition,
// // //         zoom: _currentZoom,
// // //       ),
// // //       onTap: (v){
// // //         _createIconLabel(label: 'My Car', icon: Icons.directions_car).then((BitmapDescriptor customIcon) {
// // //           setState(() {
// // //             _marker = _marker!.copyWith(
// // //               iconParam: customIcon,
// // //             );
// // //           });
// // //         });
// // //         print('currentZoom : '+_currentZoom.toString());
// // //       },
// // //       onCameraMove: _onGeoChanged,
// // //       onMapCreated: (GoogleMapController controller) {
// // //         _controller = controller;
// // //         _timerDummy = Timer(Duration(milliseconds: 300), () {
// // //           setState(() {
// // //             _mapLoading = false;
// // //             _addMarker(-6.168033, 106.900467);
// // //           });
// // //         });
// // //       },
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // class PlaceSearchScreen extends StatefulWidget {
// //   @override
// //   _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
// // }

// // class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
// //   TextEditingController _searchController = TextEditingController();
// //   late GoogleMapController _mapController;
// //   Set<Marker> _markers = {};

// //   bool _isMapReady = false;

// //   @override
// //   void dispose() {
// //     _searchController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Place Search'),
// //       ),
// //       body: Column(
// //         children: [
// //           Padding(
// //             padding: EdgeInsets.all(8.0),
// //             child: TextField(
// //               controller: _searchController,
// //               decoration: InputDecoration(
// //                 hintText: 'Search for places...',
// //               ),
// //               onSubmitted: (query) {
// //                 if (_isMapReady) {
// //                   searchPlaces(query);
// //                 } else {
// //                   // Handle scenario when map is not yet ready
// //                   // You can show a message or perform alternative actions
// //                   print('Map is not ready');
// //                 }
// //               },
// //             ),
// //           ),
// //           Expanded(
// //             child: GoogleMap(
// //               onMapCreated: (controller) {
// //                 _mapController = controller;
// //                 _isMapReady = true;
// //                 // Call your search function here and update the map markers
// //                 // if you want to display some initial markers
// //               },
// //               markers: _markers,
// //               initialCameraPosition: CameraPosition(
// //                 target: LatLng(0, 0), // Set your initial map position
// //                 zoom: 10.0,
// //               ),
// //               // onIdle: () {
// //               //   setState(() {
// //               //     _isMapReady = true;
// //               //   });
// //               // },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void searchPlaces(String query) {
// //     // Implement your search logic here
// //     // Retrieve the places matching the query

// //     // Clear previous markers
// //     _markers.clear();

// //     // Add new markers for each place found
// //     // Example code for adding a marker
// //     _markers.add(
// //       Marker(
// //         markerId: MarkerId('1'),
// //         position: LatLng(33.6844, 73.0479), // Set the latitude and longitude of the place
// //         infoWindow: InfoWindow(
// //           title: 'islamabad', // Set the name or any other details of the place
// //         ),
// //       ),

// //     );
// //     _markers.add(
// //       Marker(
// //         markerId: MarkerId('2'),
// //         position: LatLng(35.7699, 71.7741), // Set the latitude and longitude of the place
// //         infoWindow: InfoWindow(
// //           title: 'chitral', // Set the name or any other details of the place
// //         ),
// //       ),

// //     );

// //     // Move the camera to the first marker
// //     _mapController.animateCamera(
// //       CameraUpdate.newCameraPosition(
// //         CameraPosition(
// //           target: LatLng(33.6844, 73.0479), // Set the latitude and longitude of the place
// //           zoom: 14.0,
// //         ),
// //       ),
// //     );

// //     // Update the UI
// //     setState(() {});
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';

// class PlaceSearchScreen extends StatefulWidget {
//   @override
//   _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
// }

// class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
//   TextEditingController _searchController = TextEditingController();
//   late GoogleMapController _mapController;
//   Set<Marker> _markers = {};

//   bool _isMapReady = false;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Place Search'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search for places...',
//               ),
//               onChanged: (value) {
//                 searchSuggestions(value);
//               },
//               onSubmitted: (query) {
//                 searchPlaces(query);
//               },
//             ),
//           ),
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: (controller) {
//                 _mapController = controller;
//                 _isMapReady = true;
//               },
//               markers: _markers,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(0, 0), // Set your initial map position
//                 zoom: 10.0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void searchSuggestions(String query) async {
//     // Retrieve suggestions based on the query
//     List<Location> locations = await locationFromAddress(query);

//     // Clear previous markers
//     _markers.clear();

//     // Add suggestion markers for each location
//     _markers.addAll(locations.map((location) {
//       return Marker(
//         markerId: MarkerId(location.toString()),
//         position: LatLng(location.latitude, location.longitude),
//         infoWindow: InfoWindow(
//           title: 'shi',
//         ),
//       );
//     }));

//     // Update the UI
//     setState(() {});
//   }

//   void searchPlaces(String query) async {
//     // Retrieve the locations matching the query
//     List<Location> locations = await locationFromAddress(query);

//     if (locations.isNotEmpty) {
//       // Retrieve the latitude and longitude of the first location
//       double latitude = locations[0].latitude;
//       double longitude = locations[0].longitude;

//       // Clear previous markers
//       _markers.clear();

//       // Add marker for the selected location
//       _markers.add(
//         Marker(
//           markerId: MarkerId('selected'),
//           position: LatLng(latitude, longitude),
//           infoWindow: InfoWindow(
//             title: query,
//           ),
//         ),
//       );

//       // Move the camera to the selected location
//       _mapController.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: LatLng(latitude, longitude),
//             zoom: 14.0,
//           ),
//         ),
//       );

//       // Update the UI
//       setState(() {});
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';

class Homemap extends StatefulWidget {
  @override
  _HomemapState createState() => _HomemapState();
}

class _HomemapState extends State<Homemap> {
  String googleApikey = "AIzaSyCkH9s2teNLu81sYK1z_vDwBv1WW7UhiUc";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(33.6844, 73.0479);
  String location = "Search Location";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Place Search Autocomplete Google Map"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Stack(children: [
          //   GoogleMap( //Map widget from google_maps_flutter package
          //       zoomGesturesEnabled: true, //enable Zoom in, out on map
          //       initialCameraPosition: CameraPosition( //innital position in map
          //         target: startLocation, //initial position
          //         zoom: 14.0, //initial zoom level
          //       ),
          //       mapType: MapType.normal, //map type
          //       onMapCreated: (controller) { //method called when map is created
          //         setState(() {
          //           mapController = controller;
          //         });
          //       },
          //  ),

          //search autoconplete input
          Positioned(
              //search input bar
              top: 10,
              child: InkWell(
                  onTap: () async {
                    var place = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: googleApikey,
                      mode: Mode.overlay,
                      types: [],
                      strictbounds: false,
                      components: [Component(Component.country, 'pk')],
                      onError: (err) {
                        print(err);
                      },
                    );

                    if (place != null) {
                      setState(() {
                        location = place.description.toString();
                      });

                      //form google_maps_webservice package
                      final plist = GoogleMapsPlaces(
                        apiKey: googleApikey,
                        apiHeaders: await GoogleApiHeaders().getHeaders(),
                        //from google_api_headers package
                      );
                      String placeid = place.placeId ?? "0";
                      final detail = await plist.getDetailsByPlaceId(placeid);
                      final geometry = detail.result.geometry!;
                      final lat = geometry.location.lat;
                      final lang = geometry.location.lng;
                      var newlatlang = LatLng(lat, lang);

                      //move map camera to selected place with animation
                      mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                              CameraPosition(target: newlatlang, zoom: 17)));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            title: Text(
                              location,
                              style: TextStyle(fontSize: 18),
                            ),
                            trailing: Icon(Icons.search),
                            dense: true,
                          )),
                    ),
                  )))
        ]));
  }
}
