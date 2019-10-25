import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_devfest/config/config_bloc.dart';
import 'package:flutter_devfest/utils/devfest.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final bool isFirstDay;

  MapPage({@required this.isFirstDay});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _controller;
  bool isMapCreated = false;
  LatLng _festLocation;
  String _placeTitle;
  String _placeDesc;

  @override
  void initState() {
    _updateMap();
    super.initState();
  }

  CameraPosition _position;

  void _updateMap() {
    _placeTitle = widget.isFirstDay
        ? Devfest.firstDayLocationName
        : Devfest.secondDayLocationName;
    _placeDesc = widget.isFirstDay
        ? Devfest.firstDayLocationDesc
        : Devfest.secondDayLocationDesc;
    _festLocation = widget.isFirstDay
        ? Devfest.firstDayLocation
        : Devfest.secondDayLocation;
    _position = CameraPosition(
      target: _festLocation,
      zoom: 14.4746,
    );
    Future.delayed(Duration()).then((_) {
      if (isMapCreated)
        _controller.animateCamera(CameraUpdate.newLatLng(_festLocation));
    });
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("marker_1"),
          position: _festLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          )),
    ].toSet();
  }

  changeMapMode() {
    if (ConfigBloc().darkModeOn) {
      getJsonFile("assets/nightmode.json").then(setMapStyle);
    } else {
      getJsonFile("assets/daymode.json").then(setMapStyle);
    }
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    _updateMap();
    if (isMapCreated) {
      changeMapMode();
    }
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: _createMarker(),
          initialCameraPosition: _position,
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
            isMapCreated = true;
            changeMapMode();
            setState(() {});
          },
        ),
        IgnorePointer(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "$_placeTitle\n",
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    children: [
                      TextSpan(
                          text: "$_placeDesc",
                          style: Theme.of(context).textTheme.subtitle,
                          children: []),
                    ]),
              )),
        )
      ],
    );
  }
}
