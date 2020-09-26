import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<Destination> routes = <Destination>[
  Destination('Search', Icons.search),
  Destination('Bookings', Icons.bookmarks),
  Destination('Notifications', Icons.notifications),
  Destination('Profile', Icons.person)
];
