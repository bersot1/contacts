import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/address.repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressView extends StatefulWidget {
  final ContactModel model;

  AddressView({
    this.model,
  });
  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final AddressRepository _addressRepository = AddressRepository();
  Set<Marker> markers = Set<Marker>();
  GoogleMapController mapController;
  LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    if (widget.model.latLng != null && widget.model.latLng != "") {
      var values = widget.model.latLng.split(',');
      _center = LatLng(
        double.parse(values[0]),
        double.parse(
          values[1],
        ),
      );
    }
  }

  setMapPosition(title, snippet) {
    mapController.animateCamera(CameraUpdate.newLatLng(_center));
    Marker marker = Marker(
      markerId: MarkerId("1"),
      position: _center,
      infoWindow: InfoWindow(
        title: title,
        snippet: snippet,
      ),
    );
    markers.add(marker);
    setState(() {});
  }

  setCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _center = LatLng(position.latitude, position.longitude);
  }

  onSearch(address) {
    _addressRepository.searchAdress(address).then((data) {
      print(data);
      _center = LatLng(data['lat'], data['long']);

      setMapPosition(data['addressLine1'], data['addressLine2']);
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Endereço do Contato"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: ListTile(
              title: Text(
                "Endereço atual",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.model.addressLine1),
                  Text(widget.model.addressLine2),
                ],
              ),
              isThreeLine: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Container(
              height: 80,
              child: TextField(
                decoration: InputDecoration(labelText: "Pesquisar...."),
                onSubmitted: (val) {
                  onSearch(val);
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                markers: markers,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setMapPosition("Google Portland", "Snippet nao informado");
        },
        child: Icon(
          Icons.my_location,
        ),
      ),
    );
  }
}
