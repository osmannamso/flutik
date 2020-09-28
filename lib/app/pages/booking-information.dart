import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Бронь: 15:00 - 18:00, 25 сен'),
        backgroundColor: Colors.amber[800]
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '15:00 - 18:00, 25 сен',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'bookings/pitch');
                },
                child: Text(
                  'Мини футбольное поле',
                  style: TextStyle(color: Colors.amber[800]),
                ),
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text('10 000 ТГ')
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text('Абая Байтурсынова 45'),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: InkWell(
                onTap: () async {
                  const url = 'tel: +77472611215';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text(
                  '+7 747 261 1215',
                  style: TextStyle(
                    color: Colors.amber[800]
                  ),
                )
              )
            )
          ],
        )
      )
    );
  }
}
