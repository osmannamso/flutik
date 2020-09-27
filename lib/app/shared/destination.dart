import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<Destination> routes = <Destination>[
  Destination('Поиск', Icons.search),
  Destination('Брони', Icons.bookmarks),
  Destination('Уведомления', Icons.notifications),
  Destination('Профиль', Icons.person)
];
