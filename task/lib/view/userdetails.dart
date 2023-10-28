import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task/model/model.dart';
import 'package:flutter_map/flutter_map.dart';

class UserDetailsScreen extends StatelessWidget {
  late final User user;
  UserDetailsScreen(
    this.user,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Column(
        children: <Widget>[
          Text('ID: ${user.id}'),
          Text('Latitude:${user.lat}'),
          Text("Longitude :${user.lng} "),
          Flexible(
              child: FlutterMap(
            options: MapOptions(
              center: LatLng(user.lat, user.lng),
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(markers: [
                Marker(
                  point: LatLng(user.lat, user.lng),
                  width: 80,
                  height: 80,
                  builder: (context) => Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                )
              ])
            ],
          ))
        ],
      ),
    );
  }
}
